# Architecture - AI RAG Template

## Overview

```
Documents → Ingest (chunk + embed) → Vector Store
                                           ↓
User Query → Retrieve (top-k) → Generate (LLM) → Answer
                                           ↓
                                    Eval Hooks (metrics)
```

## Components

| Module | Responsibility |
|--------|----------------|
| `src/ingest.py` | Load documents, chunk text, embed, persist |
| `src/retrieve.py` | Semantic search, context assembly |
| `src/generate.py` | Prompt construction, LLM call, pipeline orchestration |
| `src/eval/metrics.py` | Metric registry, callbacks, eval artifact persistence |

## Evaluation Hooks

The `EvalHooks` class fires after each pipeline run:

- **Built-in metrics:** faithfulness, relevance, latency (stubs - replace in production)
- **Callbacks:** register custom `on_complete` handlers for tracing or dashboards
- **Persistence:** JSON artifacts written to `EVAL_OUTPUT_DIR`

Extend with:

- Ragas, DeepEval, or custom LLM-as-judge scorers
- Online eval sampling (e.g., 5% of production queries)
- Regression gates in CI using a golden Q&A dataset

## Design Decisions

Document production choices in an ADR under your project's `architecture/decisions/` folder. Reference [event-driven pattern](../../../architecture/patterns/) and [AI Engineering OS standards](../../../standards/) as needed.

## Security

- Never log raw prompts containing PII without redaction
- Validate and sanitize document sources at ingest time
- Store API keys in secrets manager, not in `.env` in production
