# Setup

## Prerequisites

- Python 3.11+
- Optional: Docker for full stack (API + PostgreSQL + Redis)

## Local development

```bash
cd starter-kits/fastapi-enterprise
python -m venv .venv
source .venv/bin/activate   # Windows: .venv\Scripts\activate
pip install -e ".[dev]"
cp .env.example .env
uvicorn src.main:app --reload --host 0.0.0.0 --port 8000
```

Open [http://localhost:8000/docs](http://localhost:8000/docs) for interactive API docs.

Health endpoint: `GET /v1/health`

## Docker (API + PostgreSQL + Redis)

```bash
docker compose -f docker/docker-compose.yml up --build
```

## Scripts

| Command | Purpose |
|---------|---------|
| `uvicorn src.main:app --reload` | Development server |
| `pytest` | Run tests |
| `ruff check src tests` | Lint |

## Environment variables

See `.env.example`. Settings are validated at startup via `pydantic-settings` in `src/config.py`.
