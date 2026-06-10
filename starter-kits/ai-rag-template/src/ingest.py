"""Document ingestion: load, chunk, embed, and persist to vector store."""

from __future__ import annotations

import hashlib
import json
import logging
from dataclasses import dataclass, field
from pathlib import Path
from typing import Iterable, Protocol

from src.config import Settings, get_settings

logger = logging.getLogger(__name__)


@dataclass(frozen=True)
class Document:
    id: str
    text: str
    metadata: dict[str, str] = field(default_factory=dict)


@dataclass(frozen=True)
class Chunk:
    id: str
    document_id: str
    text: str
    embedding: list[float]
    metadata: dict[str, str] = field(default_factory=dict)


class Embedder(Protocol):
    def embed(self, texts: list[str]) -> list[list[float]]:
        ...


class StubEmbedder:
    """Deterministic stub embedder for local dev and tests."""

    def __init__(self, dimension: int = 1536) -> None:
        self.dimension = dimension

    def embed(self, texts: list[str]) -> list[list[float]]:
        vectors: list[list[float]] = []
        for text in texts:
            seed = int(hashlib.sha256(text.encode()).hexdigest(), 16)
            vectors.append([(seed >> (i % 32) & 0xFF) / 255.0 for i in range(self.dimension)])
        return vectors


def chunk_text(text: str, chunk_size: int, overlap: int) -> list[str]:
    if chunk_size <= 0:
        raise ValueError("chunk_size must be positive")
    if overlap >= chunk_size:
        raise ValueError("overlap must be less than chunk_size")

    chunks: list[str] = []
    start = 0
    while start < len(text):
        end = min(start + chunk_size, len(text))
        chunks.append(text[start:end])
        if end == len(text):
            break
        start += chunk_size - overlap
    return chunks


def ingest_documents(
    documents: Iterable[Document],
    *,
    settings: Settings | None = None,
    embedder: Embedder | None = None,
) -> list[Chunk]:
    """Ingest documents into chunked, embedded records ready for the vector store."""
    cfg = settings or get_settings()
    embed = embedder or StubEmbedder(dimension=cfg.embedding_dimension)

    doc_list = list(documents)
    all_chunks: list[Chunk] = []
    for doc in doc_list:
        text_chunks = chunk_text(doc.text, cfg.chunk_size, cfg.chunk_overlap)
        embeddings = embed.embed(text_chunks)
        for idx, (chunk_text_value, embedding) in enumerate(zip(text_chunks, embeddings)):
            chunk_id = f"{doc.id}::{idx}"
            all_chunks.append(
                Chunk(
                    id=chunk_id,
                    document_id=doc.id,
                    text=chunk_text_value,
                    embedding=embedding,
                    metadata={**doc.metadata, "chunk_index": str(idx)},
                )
            )

    logger.info("Ingested %d chunks from %d documents", len(all_chunks), len(doc_list))
    return all_chunks


def persist_chunks(chunks: list[Chunk], store_path: Path | None = None) -> Path:
    """Persist chunks to a JSON-lines file (swap for real vector DB in production)."""
    cfg = get_settings()
    path = store_path or Path(cfg.vector_store_path)
    path.mkdir(parents=True, exist_ok=True)
    out_file = path / "chunks.jsonl"

    with out_file.open("w", encoding="utf-8") as fh:
        for chunk in chunks:
            record = {
                "id": chunk.id,
                "document_id": chunk.document_id,
                "text": chunk.text,
                "embedding": chunk.embedding,
                "metadata": chunk.metadata,
            }
            fh.write(json.dumps(record) + "\n")

    logger.info("Persisted %d chunks to %s", len(chunks), out_file)
    return out_file
