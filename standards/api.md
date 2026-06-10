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
