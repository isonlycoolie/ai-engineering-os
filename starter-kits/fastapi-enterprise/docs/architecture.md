# Architecture

Production-oriented FastAPI layout with versioned routes, structured logging, and datastore stubs.

## Layout

```
src/
├── main.py           # Application factory and lifespan
├── config.py         # Environment validation (pydantic-settings)
├── logging_config.py # JSON logging via structlog
├── routers/          # HTTP route modules
├── schemas/          # Pydantic models (envelope, domain DTOs)
├── db/postgres.py    # PostgreSQL URL factory (ready to extend)
└── cache/redis.py    # Redis URL factory (ready to extend)
```

## API envelope

All responses follow [`standards/api.md`](../../../standards/api.md):

```json
{
  "success": true,
  "data": {},
  "meta": {},
  "error": null
}
```

Response field names use camelCase. Routes are versioned under `/v1/`.

## Logging

Structured JSON logs are emitted via `structlog` with ISO timestamps and log levels.
Configure verbosity with `LOG_LEVEL`.

## Extending

1. Add routers under `src/routers/` and include them in `main.py`.
2. Open database/redis connections in the `lifespan` context manager.
3. Expand `/v1/health` checks to ping PostgreSQL and Redis when connections are wired.
