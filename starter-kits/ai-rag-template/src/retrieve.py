"""Retrieval: semantic search and context assembly."""

from __future__ import annotations

import json
import logging
import math
from dataclasses import dataclass
from pathlib import Path

from src.config import Settings, get_settings
from src.ingest import Chunk, StubEmbedder

logger = logging.getLogger(__name__)


@dataclass(frozen=True)
class RetrievedChunk:
    chunk: Chunk
    score: float


def cosine_similarity(a: list[float], b: list[float]) -> float:
    dot = sum(x * y for x, y in zip(a, b))
    norm_a = math.sqrt(sum(x * x for x in a))
    norm_b = math.sqrt(sum(y * y for y in b))
    if norm_a == 0 or norm_b == 0:
        return 0.0
    return dot / (norm_a * norm_b)


def load_chunks(store_path: Path | None = None, settings: Settings | None = None) -> list[Chunk]:
    cfg = settings or get_settings()
    path = store_path or Path(cfg.vector_store_path)
    chunks_file = path / "chunks.jsonl"
    if not chunks_file.exists():
        return []

    chunks: list[Chunk] = []
    with chunks_file.open(encoding="utf-8") as fh:
        for line in fh:
            record = json.loads(line)
            chunks.append(
                Chunk(
                    id=record["id"],
                    document_id=record["document_id"],
                    text=record["text"],
                    embedding=record["embedding"],
                    metadata=record.get("metadata", {}),
                )
            )
    return chunks


def retrieve(
    query: str,
    *,
    top_k: int | None = None,
    settings: Settings | None = None,
    chunks: list[Chunk] | None = None,
) -> list[RetrievedChunk]:
    """Retrieve top-k chunks by cosine similarity to the query embedding."""
    cfg = settings or get_settings()
    k = top_k or cfg.retrieval_top_k
    corpus = chunks if chunks is not None else load_chunks(settings=cfg)

    embedder = StubEmbedder(dimension=cfg.embedding_dimension)
    query_vector = embedder.embed([query])[0]

    scored = [
        RetrievedChunk(chunk=chunk, score=cosine_similarity(query_vector, chunk.embedding))
        for chunk in corpus
    ]
    scored.sort(key=lambda r: r.score, reverse=True)
    results = scored[:k]

    logger.info("Retrieved %d chunks for query (corpus size=%d)", len(results), len(corpus))
    return results


def assemble_context(retrieved: list[RetrievedChunk]) -> str:
    """Join retrieved chunks into a single context block for the LLM."""
    if not retrieved:
        return ""
    parts = [f"[{r.chunk.document_id}] {r.chunk.text}" for r in retrieved]
    return "\n\n---\n\n".join(parts)
