# Standards

## Contract-first

- Define or update the API contract before parallel UI/backend work diverges.
- Shared types or OpenAPI should be the source of truth for field names and errors.

## Vertical slices

- Prefer thin end-to-end slices over long-lived partially integrated branches.
- Each slice should be demoable and testable across layers.

## Consistency

- Error codes and validation messages must read the same in API docs and UI copy.
- Auth/session behavior must match on client and server.

## Git discipline

- Coordinate PRs: one focused PR per layer or one small vertical slice PR. Avoid mega-PRs.
