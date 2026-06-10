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
