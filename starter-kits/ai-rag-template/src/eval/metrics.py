"""Evaluation hooks and metrics for the RAG pipeline."""

from __future__ import annotations

import json
import logging
from dataclasses import asdict, dataclass, field
from datetime import datetime, timezone
from pathlib import Path
from typing import Callable

logger = logging.getLogger(__name__)

MetricFn = Callable[["PipelineResult"], float]


@dataclass
class PipelineResult:
    query: str
    answer: str
    context: str
    retrieved_count: int
    latency_ms: float
    model: str
    metrics: dict[str, float] = field(default_factory=dict)


def faithfulness_score(result: PipelineResult) -> float:
    """Stub: fraction of answer tokens present in context (replace with LLM-as-judge)."""
    if not result.answer.strip():
        return 0.0
    answer_tokens = set(result.answer.lower().split())
    context_tokens = set(result.context.lower().split())
    if not answer_tokens:
        return 0.0
    overlap = len(answer_tokens & context_tokens)
    return overlap / len(answer_tokens)


def relevance_score(result: PipelineResult) -> float:
    """Stub: heuristic based on retrieval count (replace with embedding similarity)."""
    if result.retrieved_count == 0:
        return 0.0
    return min(1.0, result.retrieved_count / 5.0)


def latency_score(result: PipelineResult) -> float:
    """Lower latency is better; normalize against 5s budget."""
    budget_ms = 5000.0
    return max(0.0, 1.0 - (result.latency_ms / budget_ms))


DEFAULT_METRICS: dict[str, MetricFn] = {
    "faithfulness": faithfulness_score,
    "relevance": relevance_score,
    "latency": latency_score,
}


@dataclass
class EvalHooks:
    """Pluggable evaluation hooks invoked after each pipeline run."""

    enabled: bool = True
    output_dir: str = "./data/eval"
    metrics: dict[str, MetricFn] = field(default_factory=lambda: dict(DEFAULT_METRICS))
    on_complete_callbacks: list[Callable[[PipelineResult], None]] = field(default_factory=list)

    def register_metric(self, name: str, fn: MetricFn) -> None:
        self.metrics[name] = fn

    def register_callback(self, fn: Callable[[PipelineResult], None]) -> None:
        self.on_complete_callbacks.append(fn)

    def compute_metrics(self, result: PipelineResult) -> dict[str, float]:
        scores: dict[str, float] = {}
        for name, fn in self.metrics.items():
            try:
                scores[name] = fn(result)
            except Exception:
                logger.exception("Metric %s failed", name)
                scores[name] = 0.0
        return scores

    def on_pipeline_complete(self, result: PipelineResult) -> None:
        if not self.enabled:
            return

        result.metrics = self.compute_metrics(result)

        for callback in self.on_complete_callbacks:
            callback(result)

        self._persist_result(result)
        logger.info("Eval complete: %s", result.metrics)

    def _persist_result(self, result: PipelineResult) -> None:
        out_dir = Path(self.output_dir)
        out_dir.mkdir(parents=True, exist_ok=True)
        timestamp = datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%SZ")
