# Backend Engineer Agent - Coding Standards

Language- and domain-specific quality rules. Global standards in [`standards/`](../../standards/) take precedence where they overlap.

## General Principles

- Strong typing everywhere - no `any` (TypeScript) or untyped dicts at boundaries (Python)
- Every public function has a defined input contract and output contract
- Self-documenting names; comments explain *why*, not *what*
- Prefer composition over inheritance; prefer pure functions over stateful logic where possible
- Smallest change that satisfies the requirement - no drive-by refactors

## Node.js / TypeScript

### Project Structure

```
src/
├── routes/           # HTTP route definitions - thin, no business logic
├── controllers/      # Request/response mapping, validation invocation
├── services/         # Business logic
├── repositories/     # Data access abstraction
├── models/           # Domain types and entities
├── middleware/       # Auth, logging, rate limiting, error handling
├── jobs/             # Background job handlers
├── config/           # Validated environment configuration
└── utils/            # Pure utility functions
```

### Conventions

- Use `strict` TypeScript compiler options
- Validate environment at startup with Zod or equivalent - fail fast on misconfiguration
- Async errors: use `async/await`; wrap route handlers in centralized error middleware
- ORM: Prisma or TypeORM per project convention - parameterized queries only
- DTOs: separate request/response types from domain entities
- Dependencies: inject via constructor or factory - avoid global singletons for testability

### Error Handling

```typescript
// Standard error shape aligned with standards/api.md
throw new AppError({
  code: 'USER_NOT_FOUND',
  message: 'No user exists with the provided ID. Verify the ID and try again.',
  statusCode: 404,
});
```

### Logging

```typescript
logger.info({ requestId, userId, duration_ms }, 'Order created');
logger.error({ requestId, error: { code, detail } }, 'Payment failed');
```

## Python / FastAPI

### Project Structure

```
app/
├── api/
│   └── v1/
│       ├── routes/       # Router modules per domain
│       └── dependencies/ # FastAPI Depends() providers
├── services/             # Business logic
├── repositories/         # Data access
├── models/               # SQLAlchemy / domain models
├── schemas/              # Pydantic request/response models
├── core/                 # Config, security, logging
├── jobs/                 # Celery / ARQ / background tasks
└── main.py
```

### Conventions

- Pydantic v2 models for all request/response validation
- `async def` for I/O-bound endpoints; sync only when justified
- SQLAlchemy 2.0 style with explicit sessions - no implicit global session
- Dependency injection via FastAPI `Depends()`
- Type hints on all public functions - `mypy` or `pyright` clean
- Settings via `pydantic-settings` - validated at import/startup

### Error Handling

```python
raise HTTPException(
    status_code=404,
    detail={
        "code": "USER_NOT_FOUND",
        "message": "No user exists with the provided ID. Verify the ID and try again.",
    },
)
```

## PostgreSQL

- Table and column names: `snake_case`
- Primary keys: `UUID` or `BIGSERIAL` per project convention - document choice
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
