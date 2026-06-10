# Security Standards

Security is a system property, not a phase.

## Authentication and Authorization

- Use established libraries - no custom cryptography
- Authorization enforced at service layer, not only API gateway
- Every endpoint authenticated unless explicitly justified and documented
- JWT: short-lived access tokens, refresh token rotation

## Input and Output

- Validate all inputs against schema before processing
- Sanitize outputs before rendering in UI
- Parameterized queries only - no string concatenation for SQL

## Transport and Headers

- HTTPS on all endpoints
- Security headers: CSP, HSTS, X-Frame-Options, X-Content-Type-Options
- Rate limiting on all public endpoints
- CORS: never `Access-Control-Allow-Origin: *` in production

## Secrets

- Stored in approved vault - not in source or version control
- Rotated on defined schedule
- Never logged (passwords, tokens, PII)

## Dependencies

- No critical or high-severity vulnerabilities in production dependencies
- New dependencies require justification in ADR or PR description

## Agent Invocation

| Task | Prompt / Agent |
|------|----------------|
| PR security review | [stage-05-security-review.md](../workflows/prompts/stage-05-security-review.md) |
| Threat modeling | [security-engineer/prompts/primary.md](../agents/security-engineer/prompts/primary.md) |
| Dependency audit | [dependency-audit.md](../workflows/prompts/dependency-audit.md) |
| Pre-release checklist | [security-engineer/checklists/security-review.md](../agents/security-engineer/checklists/security-review.md) |
