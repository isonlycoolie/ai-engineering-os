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
