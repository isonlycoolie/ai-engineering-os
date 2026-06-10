# Starter Kits

Production-ready project templates implementing AI Engineering OS standards from day one.

## Kits

| Kit | Stack | Use when |
|-----|-------|----------|
| [nextjs-enterprise](nextjs-enterprise/) | Next.js, TypeScript, Tailwind | Full-stack web apps |
| [fastapi-enterprise](fastapi-enterprise/) | FastAPI, PostgreSQL, Redis | Python APIs |
| [django-enterprise](django-enterprise/) | Django REST, Celery | Python full-stack |
| [microservice-template](microservice-template/) | Node.js TypeScript | Standalone services |
| [ai-rag-template](ai-rag-template/) | Python RAG pipeline | AI retrieval workflows |
| [kafka-event-template](kafka-event-template/) | Kafka events | Event-driven systems |

## Each Kit Includes

- `src/` - application source
- `tests/` - unit tests with CI
- `docker/` - container configs
- `.env.example` - documented environment variables
- `.github/workflows/` - lint, test, build, security scan stub
- `docs/setup.md`, `architecture.md`, `deployment.md`

## Getting Started

1. Copy or use a kit as a submodule
2. Follow the kit's `docs/setup.md`
3. Run feature delivery per [developer journey](../docs/developer-journey/03-feature-delivery.md)

Back to [START HERE](../docs/START-HERE.md).
