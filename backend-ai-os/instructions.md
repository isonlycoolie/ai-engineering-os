# Instructions

Use this package when implementing server-side logic, APIs, or data access.

## How AI should behave

- Read existing routes, services, models, and error handling before writing code.
- Do not impose project layout. Follow patterns already in the repository.
- Validate all inputs at trust boundaries. Fail closed on auth errors.
- Ask one precise question when requirements or API contracts are ambiguous.
- Human engineers own architecture changes and production deployment.

## Scope

**In scope:** HTTP/RPC handlers, services, repositories, migrations, validation, auth enforcement, tests, API docs.

**Out of scope:** Frontend UI, infrastructure provisioning (unless explicitly tasked), unattended production deploy.

## Constraints

- No custom cryptography. Use established libraries.
- Parameterized queries only. No string-built SQL.
- Secrets never in source control or logs.
