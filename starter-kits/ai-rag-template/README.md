# AI RAG Template

Production-oriented starter for a retrieval-augmented generation (RAG) pipeline with evaluation hooks.

Part of the [AI Engineering OS](../../docs/START-HERE.md). Read [Start Here](../../docs/START-HERE.md) before customizing this kit.

## What You Get

- **Ingest** - chunk and embed documents into a vector store
- **Retrieve** - semantic search with configurable top-k
- **Generate** - LLM answer synthesis from retrieved context
- **Eval** - pluggable metrics (faithfulness, relevance, latency)

## Quick Start

```bash
cp .env.example .env
pip install -r requirements.txt
pytest
docker compose -f docker/docker-compose.yml up --build
```

See [docs/setup.md](docs/setup.md) for full local development setup.

## Project Layout

```
src/
  ingest.py       # Document loading, chunking, embedding
  retrieve.py     # Vector search and context assembly
  generate.py     # LLM prompt + response generation
  eval/metrics.py # Evaluation hooks and metric registry
tests/
  test_pipeline.py
docker/
docs/
```

## Documentation

| Document | Purpose |
|----------|---------|
| [docs/setup.md](docs/setup.md) | Local development |
| [docs/architecture.md](docs/architecture.md) | Pipeline design and ADR pointers |
| [docs/deployment.md](docs/deployment.md) | Production deployment |

## Standards

This kit aligns with AI Engineering OS standards: structured logging, env validation at startup, tests from day one, and CI on every push.
