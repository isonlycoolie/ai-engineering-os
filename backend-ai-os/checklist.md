# Checklist

# Backend Engineer - Pre-Delivery Checklist

Complete every item before submitting implementation for human review. Flag any unchecked item with explanation in the implementation summary.

## Input Validation and Security

- [ ] All inputs validated and sanitized at the API boundary (schema validation)
- [ ] All database queries use parameterized statements - no string-concatenated SQL
- [ ] Authentication enforced on all endpoints unless explicitly documented as public
- [ ] Authorization enforced at the service layer - not only at the gateway
- [ ] Rate limiting applied to public and unauthenticated endpoints (or confirmed existing)
- [ ] CORS configured with explicit allowed origins - not `*` in production
- [ ] No hardcoded secrets, credentials, or environment-specific values in source code

## Data and Persistence

- [ ] New database columns have appropriate indexes for query patterns
- [ ] Migrations are reversible and reviewed - no destructive changes without rollback plan
- [ ] No N+1 query patterns in new code paths
- [ ] Transactions scoped to atomic business operations only
- [ ] Sensitive data is never logged (passwords, tokens, full payment details, unredacted PII)

## API Contract

- [ ] All new public endpoints documented in OpenAPI spec
- [ ] Error responses follow the project standard error envelope (`code`, `message`, actionable guidance)
- [ ] Success responses follow the standard envelope (`success`, `data`, `meta`, `error`)
- [ ] API versioned at URL level (`/v1/`) - breaking changes have deprecation plan
- [ ] Pagination, filtering, and sorting behave as documented

## Observability

- [ ] Structured logging on new endpoints and error paths (correlation ID, duration, error code)
- [ ] Errors logged with sufficient context for debugging - not exposed to clients
- [ ] Health check endpoint reflects actual dependency health if modified

## Configuration

- [ ] All environment-specific values in environment variables or secrets manager
- [ ] Configuration validated at application startup - fail fast on missing/invalid config
- [ ] New environment variables documented in `.env.example`

## Testing

- [ ] Unit tests cover happy path and at least two failure modes per new public endpoint
- [ ] Integration tests cover API → database round-trip for critical paths
- [ ] No existing tests broken - full suite passes
- [ ] Test fixtures isolated - no shared mutable state

## Code Quality

- [ ] Business logic in service layer - not in controllers or route handlers
- [ ] No banned anti-patterns from [`anti-patterns.md`](../anti-patterns.md)
- [ ] Non-obvious decisions annotated with inline comments
- [ ] New dependencies justified and security-audited
- [ ] Implementation summary completed using [`templates/implementation-summary.md`](../templates/implementation-summary.md)

## Handoff

- [ ] Blast radius documented (files and services affected)
- [ ] Open questions and items requiring human decision listed explicitly
- [ ] Rollback path documented for schema or contract changes
