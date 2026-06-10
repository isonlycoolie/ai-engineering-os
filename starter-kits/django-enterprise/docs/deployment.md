# Deployment - Django Enterprise

## Pre-Production Checklist

- [ ] `DJANGO_DEBUG=false`
- [ ] Strong `DJANGO_SECRET_KEY` from secrets manager
- [ ] `DJANGO_ALLOWED_HOSTS` set to production domains
- [ ] PostgreSQL connection pooling configured
- [ ] Celery workers scaled independently of web tier
- [ ] Health check wired to load balancer (`/v1/health/`)
- [ ] Structured logs shipped to aggregation pipeline

## Container Image

Build from [docker/Dockerfile](../docker/Dockerfile):

```bash
docker build -f docker/Dockerfile -t django-enterprise:latest .
```

Run migrations before serving traffic:

```bash
python manage.py migrate --noinput
```

## Process Model

| Process | Command |
|---------|---------|
| Web | `gunicorn config.wsgi:application --bind 0.0.0.0:8000 --workers 4` |
| Worker | `celery -A config worker --loglevel=info` |

Scale web and worker replicas independently based on HTTP vs queue load.

## Environment

Inject all variables from [.env.example](../.env.example) via your platform's secrets mechanism. Never commit `.env` to version control.

## Database Migrations

Follow expand → migrate → contract per [database standards](../../../standards/database.md). Run migrations as a release step before switching traffic.

## Monitoring

- Alert on `/v1/health/` non-200 responses
- Track Celery queue depth and task failure rate
- Monitor PostgreSQL connection count and query latency (p95)

## Rollback

- Revert container image to previous tag
- Roll back migrations only when reversible and coordinated with schema state
