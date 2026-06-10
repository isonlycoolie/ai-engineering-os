# Deployment

## Container image

Multi-stage `docker/Dockerfile` builds a wheel and runs Uvicorn on port 8000.

```bash
docker compose -f docker/docker-compose.yml up --build -d
```

## Environment

Set these in production:

| Variable | Description |
|----------|-------------|
| `ENVIRONMENT` | `production` |
| `DATABASE_URL` | PostgreSQL connection string |
| `REDIS_URL` | Redis connection string |
| `LOG_LEVEL` | `INFO` or `WARNING` |

## Health checks

Probe `GET /v1/health` - returns the standard envelope with `data.status`.

Wire orchestrator probes to port 8000. Extend health checks to validate database and cache connectivity before marking the service ready.

## CI

`.github/workflows/ci.yml` runs Ruff lint and pytest on push/PR to `main`.

When copying this kit into a standalone repository, move the workflow to the repo root and remove the `working-directory` override.

## Production checklist

- [ ] Inject secrets via platform secret manager (not `.env` files)
- [ ] Run database migrations before traffic (add Alembic when needed)
- [ ] Configure autoscaling on CPU/latency
- [ ] Ship logs to your observability stack (JSON logs are ready)
