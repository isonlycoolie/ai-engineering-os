"""RAG pipeline integration tests."""

from pathlib import Path

import pytest

from src.eval.metrics import EvalHooks, faithfulness_score
from src.generate import StubLLMClient, run_pipeline
from src.ingest import Document, ingest_documents, persist_chunks
from src.config import Settings


@pytest.fixture
def settings(tmp_path: Path) -> Settings:
    return Settings(
        VECTOR_STORE_PATH=str(tmp_path / "vector_store"),
        EVAL_OUTPUT_DIR=str(tmp_path / "eval"),
        EVAL_ENABLED=True,
        EMBEDDING_DIMENSION=8,
        CHUNK_SIZE=50,
        CHUNK_OVERLAP=10,
        RETRIEVAL_TOP_K=2,
    )


@pytest.fixture
def indexed_corpus(settings: Settings) -> None:
    docs = [
        Document(id="doc-1", text="Kafka is an event streaming platform used for async messaging."),
        Document(id="doc-2", text="RAG combines retrieval with generation for grounded answers."),
    ]
    chunks = ingest_documents(docs, settings=settings)
    persist_chunks(chunks, store_path=Path(settings.vector_store_path))


def test_ingest_chunks_documents(settings: Settings) -> None:
    doc = Document(id="d1", text="a" * 120)
    chunks = ingest_documents([doc], settings=settings)
    assert len(chunks) >= 2
    assert all(c.document_id == "d1" for c in chunks)


def test_pipeline_end_to_end(indexed_corpus: None, settings: Settings) -> None:
    captured: list = []

    hooks = EvalHooks(
        enabled=True,
        output_dir=settings.eval_output_dir,
        on_complete_callbacks=[lambda r: captured.append(r)],
    )

    result = run_pipeline(
        "What is RAG?",
        settings=settings,
        llm=StubLLMClient(),
        eval_hooks=hooks,
    )

    assert result.answer
    assert result.retrieved_count > 0
    assert "faithfulness" in result.metrics
    assert len(captured) == 1


def test_faithfulness_score() -> None:
    from src.eval.metrics import PipelineResult

    result = PipelineResult(
        query="q",
        answer="kafka event streaming",
        context="Kafka is an event streaming platform.",
        retrieved_count=1,
        latency_ms=10.0,
        model="stub",
    )
    score = faithfulness_score(result)
    assert 0.0 < score <= 1.0
