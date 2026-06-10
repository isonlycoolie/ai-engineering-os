# Local Setup - Django Enterprise

## Prerequisites

- Python 3.12+
- PostgreSQL 16+
- Redis 7+ (for Celery)
- Docker (optional, recommended for first run)

## Docker (recommended)

```bash
cp .env.example .env
docker compose -f docker/docker-compose.yml up --build
```

Verify:

```bash
curl http://localhost:8000/v1/health/
```

## Manual Setup

```bash
python -m venv .venv
source .venv/bin/activate   # Windows: .venv\Scripts\activate
pip install -r requirements-dev.txt
cp .env.example .env
```

Start PostgreSQL and Redis, then:

```bash
python manage.py migrate
python manage.py runserver
```

Run Celery worker in a separate terminal:

```bash
celery -A config worker --loglevel=info
```

## Tests

```bash
pytest
```

## Lint

```bash
ruff check .
```

## Environment Variables

See [.env.example](../.env.example). Required variables are validated at startup; missing values cause immediate exit with a clear error.

## Next Steps

- Read [architecture.md](architecture.md) before adding domain models
- Follow the [AI Engineering OS](../../docs/START-HERE.md) feature delivery workflow
