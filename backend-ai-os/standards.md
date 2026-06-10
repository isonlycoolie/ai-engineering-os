# Standards

# API Standards

All APIs exposed by any service in this system follow these rules.

## Request and Response Format

- All request and response bodies are JSON
- All responses use a consistent envelope:

```json
{
  "success": true,
  "data": {},
  "meta": {},
  "error": null
}
```

- Error responses include machine-readable `code` and human-readable `message`
- Error messages include actionable guidance

## Versioning

- APIs versioned at URL level: `/v1/`, `/v2/`
- Versions never removed without minimum 90-day deprecation
- Deprecation communicated via response headers and changelog

## Naming

- Resources: plural nouns (`/users`, `/orders`)
- Actions: HTTP verbs (GET retrieve, POST create, PATCH update, DELETE remove)
- Query parameters: `snake_case`
- Response fields: `camelCase`

## Authentication

- All public endpoints require authentication unless explicitly documented otherwise
- Rate limiting on all unauthenticated endpoints

## Documentation

- Every public endpoint documented in OpenAPI
- Examples for success and common error responses

## Agent Invocation

| Task | Prompt / Agent |
|------|----------------|
| Design new API | [architecture-prompt.md](../prompts/architecture-prompt.md) |
| Implement endpoints | [backend-engineer/prompts/primary.md](../agents/backend-engineer/prompts/primary.md) |
| Review API contract | [code-review-prompt.md](../prompts/code-review-prompt.md) |
| Document APIs | [devrel-engineer/prompts/primary.md](../agents/devrel-engineer/prompts/primary.md) |

## Database

# Database Standards

## Schema Design

- Migrations versioned and reversible where possible
- Indexes planned for query patterns - not added as afterthought
- Foreign keys and constraints enforced at database level
- Soft delete vs hard delete documented per entity

## Queries

- Parameterized statements only
- No N+1 - use joins or batch loading
- Complex reporting queries may use raw SQL with review
- Transaction scope limited to related operations

## Migrations

- One logical change per migration
- Tested against copy of production schema in CI
- Backward-compatible deploys: expand → migrate → contract

## Agent Invocation

| Task | Agent |
|------|-------|
| Schema design | [architecture-engineer](../agents/architecture-engineer/) + ADR |
| Implement migrations | [backend-engineer/prompts/primary.md](../agents/backend-engineer/prompts/primary.md) |
| Query performance | [backend-engineer](../agents/backend-engineer/) + profiling evidence |

## Error handling

# Error Handling Standards

## API Errors

Use the standard envelope with structured error:

```json
{
  "success": false,
  "data": null,
  "meta": {},
  "error": {
    "code": "VALIDATION_FAILED",
    "message": "Email address is invalid",
    "details": [{ "field": "email", "reason": "format" }]
  }
}
```

- `code`: machine-readable, stable across versions
- `message`: human-readable, actionable
- `details`: optional field-level breakdown

## Application Code

- Never catch and discard exceptions silently
- Log errors with correlation ID and error code
- Do not log secrets or PII in error details
- Use typed errors at domain boundaries
- Retry with backoff only for transient failures; use circuit breakers for downstream deps

## Client/UI

- Every async operation handles loading, error, and success states
- Error messages tell the user what happened and what to do next

## Agent Invocation

| Task | Resource |
|------|----------|
| Implement error handling | [backend-engineer](../agents/backend-engineer/), [frontend-engineer](../agents/frontend-engineer/) |
| Review error messages | [devrel-engineer](../agents/devrel-engineer/) |
| Debug production errors | [debugging-prompt.md](../prompts/debugging-prompt.md) |

## Coding standards

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
