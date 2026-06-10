# Django Enterprise Starter Kit

Production-oriented Django REST API foundation with PostgreSQL, Celery, structured JSON responses, and CI.

Part of the [AI-Augmented Engineering OS](../../docs/START-HERE.md).

## Quick Start

```bash
cp .env.example .env
docker compose -f docker/docker-compose.yml up --build
curl http://localhost:8000/v1/health/
```

See [docs/setup.md](docs/setup.md) for local development without Docker.

## What's Included

- Django 5 + Django REST Framework
- JSON response envelope per [API standards](../../standards/api.md)
- Health check endpoint at `/v1/health/`
- Celery worker stub with Redis broker
- PostgreSQL via environment-driven settings
- pytest test suite
- GitHub Actions CI (lint, test, security scan)
- Docker Compose for local development

## Documentation

| Document | Purpose |
|----------|---------|
| [docs/setup.md](docs/setup.md) | Local development setup |
| [docs/architecture.md](docs/architecture.md) | System design and decisions |
| [docs/deployment.md](docs/deployment.md) | Production deployment guide |

## Standards

This kit implements conventions from the engineering OS:

- [API standards](../../standards/api.md) - JSON envelope, versioning
- [Observability standards](../../standards/observability.md) - structured logging
- [Error handling standards](../../standards/error-handling.md) - error codes and messages
- [Database standards](../../standards/database.md) - migrations and parameterized queries
