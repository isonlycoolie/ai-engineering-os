"""Generation: LLM answer synthesis from retrieved context."""

from __future__ import annotations

import logging
import time
from dataclasses import dataclass
from typing import Protocol

from src.config import Settings, get_settings
from src.eval.metrics import EvalHooks, PipelineResult
from src.retrieve import RetrievedChunk, assemble_context, retrieve

logger = logging.getLogger(__name__)


@dataclass(frozen=True)
class GenerationResult:
    answer: str
    context: str
    model: str
    latency_ms: float


class LLMClient(Protocol):
    def complete(self, prompt: str) -> str:
        ...


class StubLLMClient:
    """Deterministic stub LLM for local dev and tests."""

    def complete(self, prompt: str) -> str:
        return f"[stub response based on context length={len(prompt)}]"


def build_prompt(query: str, context: str) -> str:
    return (
        "Answer the question using only the provided context. "
        "If the context is insufficient, say you do not know.\n\n"
        f"Context:\n{context}\n\n"
        f"Question: {query}\n\n"
        "Answer:"
    )


def generate(
    query: str,
    *,
    retrieved: list[RetrievedChunk] | None = None,
    settings: Settings | None = None,
    llm: LLMClient | None = None,
) -> GenerationResult:
    """Generate an answer from a query and optional pre-retrieved chunks."""
    cfg = settings or get_settings()
    client = llm or StubLLMClient()

    chunks = retrieved if retrieved is not None else retrieve(query, settings=cfg)
    context = assemble_context(chunks)
    prompt = build_prompt(query, context)

    start = time.perf_counter()
    answer = client.complete(prompt)
    latency_ms = (time.perf_counter() - start) * 1000

    logger.info("Generated answer in %.1fms (model=%s)", latency_ms, cfg.llm_model)
    return GenerationResult(
        answer=answer,
        context=context,
        model=cfg.llm_model,
        latency_ms=latency_ms,
    )


def run_pipeline(
    query: str,
    *,
    settings: Settings | None = None,
    llm: LLMClient | None = None,
    eval_hooks: EvalHooks | None = None,
) -> PipelineResult:
    """End-to-end RAG pipeline with optional evaluation hooks."""
    cfg = settings or get_settings()
    hooks = eval_hooks or EvalHooks(enabled=cfg.eval_enabled, output_dir=cfg.eval_output_dir)

    retrieved = retrieve(query, settings=cfg)
    result = generate(query, retrieved=retrieved, settings=cfg, llm=llm)

    pipeline_result = PipelineResult(
        query=query,
        answer=result.answer,
        context=result.context,
        retrieved_count=len(retrieved),
        latency_ms=result.latency_ms,
        model=result.model,
    )

    hooks.on_pipeline_complete(pipeline_result)
    return pipeline_result
