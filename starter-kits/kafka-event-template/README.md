# Kafka Event Template

Production-oriented starter for event-driven services with schema contracts, idempotent consumers, and DLQ guidance.

Part of the [AI Engineering OS](../../docs/START-HERE.md). Read [Start Here](../../docs/START-HERE.md) before customizing this kit.

## What You Get

- **Producer** - publish versioned events with correlation IDs
- **Consumer** - idempotent processing stub with deduplication store
- **Schemas** - typed event definitions with schema versioning pattern
- **Docker Compose** - local Kafka (KRaft) for integration testing

## Quick Start

```bash
cp .env.example .env
pip install -r requirements.txt
pytest
docker compose -f docker/docker-compose.yml up -d   # start Kafka
python -m src.producer
python -m src.consumer
```

See [docs/setup.md](docs/setup.md) for full local development setup.

## Project Layout

```
src/
  producer.py         # Event publisher
  consumer.py         # Idempotent consumer stub
  schemas/events.py   # Event schema definitions
tests/
docker/
docs/
```

## Documentation

| Document | Purpose |
|----------|---------|
| [docs/setup.md](docs/setup.md) | Local development with Kafka |
| [docs/architecture.md](docs/architecture.md) | Event contracts, idempotency, DLQ |
| [docs/deployment.md](docs/deployment.md) | Production deployment |

## Related Patterns

- [Event-Driven Integration](../../architecture/patterns/event-driven.md)

## Standards

Implements AI Engineering OS event-driven requirements: schema versioning, idempotent consumers, correlation IDs, and documented DLQ/replay procedures.
