# Standards

## API design

- Consistent response envelope and actionable error codes.
- Version breaking changes explicitly. Document deprecation paths.
- Pagination, filtering, and idempotency for mutating operations where appropriate.

## Auth

- Authenticate at the boundary. Authorize in the service layer.
- Default deny. Document any public endpoints and why they are public.

## Data

- Migrations reversible when feasible. Index strategy documented for new queries.
- Transactions scoped to atomic business operations. Avoid N+1 access patterns.

## Errors and observability

- Structured logs with correlation IDs. No PII or secrets in logs.
- Map internal failures to safe client messages.

## Git discipline

- One logical change per commit. Migrations in dedicated commits when large.
