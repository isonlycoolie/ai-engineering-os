# Architecture - Django Enterprise

## Overview

```
┌─────────────┐     ┌──────────────┐     ┌────────────┐
│   Client    │────▶│  Django API  │────▶│ PostgreSQL │
└─────────────┘     └──────┬───────┘     └────────────┘
                           │
                           ▼
                    ┌──────────────┐
                    │ Celery Worker│◀── Redis (broker)
                    └──────────────┘
```

## Layers

| Layer | Location | Responsibility |
|-------|----------|----------------|
| HTTP / API | `api/` | Views, URL routing, response envelope |
| Configuration | `config/` | Settings, Celery app, WSGI/ASGI |
| Background jobs | `tasks/` | Celery task definitions |
| Persistence | Django ORM + PostgreSQL | Data models and migrations |

## API Contract

All endpoints return the standard JSON envelope defined in [API standards](../../../standards/api.md):

- `success`, `data`, `meta`, `error`
- URL versioning at `/v1/`
- Response field naming: `camelCase` in JSON payloads where applicable

## Health Checks

`GET /v1/health/` returns liveness and a database connectivity probe. Returns HTTP 503 when the database check fails.

## Background Processing

Celery is configured with Redis as broker and result backend. The `tasks.example.ping` task is a wiring stub - replace with domain tasks as features are added.

## Observability

Structured JSON logs are emitted to stdout. Extend with `requestId` propagation per [observability standards](../../../standards/observability.md) when adding middleware.

## Decisions

| Decision | Rationale |
|----------|-----------|
| Django REST Framework | Mature API layer with JSON-first rendering |
| PostgreSQL | Required relational store per kit spec |
| Celery + Redis | Standard async job pattern; Redis doubles as broker |
| Env validation at startup | Fail fast in misconfigured deployments |

## Extension Points

- Add domain apps under new packages (e.g. `orders/`, `users/`)
- Register new Celery tasks in `tasks/` or per-app `tasks.py`
- Add authentication middleware before exposing non-health endpoints
