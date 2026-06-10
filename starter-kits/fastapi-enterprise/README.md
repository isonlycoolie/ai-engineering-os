# FastAPI Enterprise Starter

Production-oriented starter kit: **FastAPI**, PostgreSQL-ready, Redis-ready, structured JSON logging,
and the standard API response envelope from AI Engineering OS.

## What's included

- Versioned health endpoint (`GET /v1/health`) with JSON envelope
- Environment validation via `pydantic-settings`
- Structured logging with `structlog`
- PostgreSQL and Redis connection stubs + docker-compose stack
- pytest health test
- GitHub Actions CI (lint, test)

## Quick start

```bash
python -m venv .venv && source .venv/bin/activate
pip install -e ".[dev]"
cp .env.example .env
uvicorn src.main:app --reload
```

## Documentation

| Doc | Description |
|-----|-------------|
| [docs/setup.md](docs/setup.md) | Local development |
| [docs/architecture.md](docs/architecture.md) | Project layout and API envelope |
| [docs/deployment.md](docs/deployment.md) | Docker and production |

## Standards

- API envelope: [`standards/api.md`](../../standards/api.md)
