# Standards

## Authentication and authorization

- Established libraries only. No custom crypto.
- Default deny authorization. Document public endpoints.

## Input and output

- Schema validation at boundaries. Parameterized queries.
- Encode/sanitize output appropriate to context (HTML, JSON, logs).

## Transport and headers

- HTTPS everywhere. Security headers configured.
- Rate limiting on public surfaces. Restrictive CORS in production.

## Secrets and dependencies

- Secrets in vault, rotated on schedule.
- No unaddressed critical/high CVEs in production dependencies.
