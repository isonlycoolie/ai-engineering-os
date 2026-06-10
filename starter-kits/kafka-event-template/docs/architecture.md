# Architecture - Kafka Event Template

## Overview

```
Producer → Kafka Topic (domain.events.v1) → Consumer (idempotent)
                    ↓ (on failure)
              DLQ Topic (domain.events.v1.dlq)
```

## Event Schema Pattern

All events use `EventEnvelope` (`src/schemas/events.py`):

| Field | Purpose |
|-------|---------|
| `schema_version` | Breaking-change version; consumers reject unknown versions |
| `event_id` | Unique ID for idempotency |
| `event_type` | Routing key for handler dispatch |
| `correlation_id` | Distributed tracing across services |
| `occurred_at` | Event timestamp (UTC) |
| `payload` | Typed payload validated per `event_type` |

**Versioning rule:** additive changes stay on the same version; breaking changes increment `schema_version` and may require a new topic (`domain.events.v2`).

## Idempotent Consumer

The consumer stub (`src/consumer.py`) deduplicates by `event_id`:

1. Check `IdempotencyStore.already_processed(event_id)`
2. If seen → skip (at-least-once delivery safe)
3. If new → validate payload, run handler, mark processed

**Production:** replace the JSON-lines file store with Redis (`SETNX`) or a DB unique constraint on `event_id`.

## Dead Letter Queue (DLQ)

When message processing fails after retries, publish the original message to the DLQ topic (`KAFKA_DLQ_TOPIC`).

This template documents the pattern; wire DLQ publishing in your handler error path:

```python
try:
    handler(envelope)
except Exception:
    dlq_producer.publish(settings.kafka_dlq_topic, key, value)
    raise
```

### DLQ Operations

- **Monitor** DLQ depth - alert when messages accumulate
- **Replay** after fixing the bug: read DLQ → re-publish to primary topic with new correlation ID
- **Document** replay runbooks in `templates/runbook.md`

See [Event-Driven Integration](../../../architecture/patterns/event-driven.md) for full requirements.

## Correlation IDs

Producers set `correlation_id` on every event. Propagate through HTTP headers (`X-Correlation-ID`) and log fields so traces span sync and async paths.

## Security

- Use SASL/SSL in production (`KAFKA_SECURITY_PROTOCOL`)
- Restrict topic ACLs per service account
- Never log full payloads containing PII
