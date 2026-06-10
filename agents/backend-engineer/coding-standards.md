- Timestamps: `created_at`, `updated_at` on all mutable tables - UTC only
- Soft deletes: `deleted_at` nullable timestamp when business requires audit trail
- Migrations: one logical change per migration file; include `up` and `down`
- Indexes: name explicitly (`idx_orders_user_id_created_at`); document query patterns
- Foreign keys: enforce referential integrity unless ADR documents exception
- See [`standards/database.md`](../../standards/database.md) for shared rules

## Redis

- Key naming: `{service}:{entity}:{id}` or `{service}:{purpose}:{identifier}`
- Always set TTL on cache keys unless ADR documents permanent cache
- Use Redis for: session cache, rate limiting, distributed locks, job queues (BullMQ)
- Never store secrets or long-lived PII in Redis without encryption and TTL justification
- Cache invalidation must be documented alongside cache write paths

## Messaging (Kafka / RabbitMQ / BullMQ)

- Messages: versioned JSON schema with `eventType`, `payload`, `correlationId`, `timestamp`
- Consumers: idempotent - safe to retry
- Dead-letter queues for poison messages
- Producers: log publish failures; do not silently drop events

## Authentication

- Access tokens: short-lived (15 minutes or per project policy)
- Refresh tokens: rotation on every successful refresh; revoke on reuse detection
- Password hashing: bcrypt or Argon2 - never MD5/SHA for passwords
- OAuth 2.0: use established libraries; validate state parameter on callback

## API Design

- REST resources: plural nouns (`/v1/users`, `/v1/orders`)
- Query parameters: `snake_case`; response fields: `camelCase`
- Pagination: cursor-based for large datasets; offset only for small, stable sets
- Idempotency: `Idempotency-Key` header on POST for payment and order endpoints
- Rate limiting on all public and unauthenticated endpoints

## Testing

| Type | Scope | Tools |
|------|-------|-------|
| Unit | Service logic, pure functions | Vitest/Jest (Node), pytest (Python) |
| Integration | API → DB round-trip | Supertest, httpx + test DB |
| Contract | OpenAPI schema compliance | Schema validation against spec |

- Test database: isolated per test run; migrations applied in CI
- Fixtures: factory pattern - no shared mutable state
- Mock external services at HTTP boundary - not internal repository methods unless unit-testing service in isolation

## Dependencies

- Pin versions in lockfiles (`package-lock.json`, `poetry.lock`, `requirements.txt`)
- New dependencies require justification: what problem, why not existing stack, license check
- Run security audit before handoff (`npm audit`, `pip-audit`, or project equivalent)
