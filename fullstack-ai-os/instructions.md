# Instructions

Use when a feature spans client and server in the same effort.

## How AI should behave

- Treat the API contract as the handshake between UI and backend work.
- Implement one vertical slice at a time when possible (endpoint + UI consumer + tests).
- Do not reorganize the whole repository. Match existing frontend and backend conventions separately.
- Escalate cross-cutting architecture decisions to a human lead.

## Scope

**In scope:** Coordinated UI + API changes, shared types or contracts, integrated tests, feature-level documentation.

**Out of scope:** Imposing monorepo structure, greenfield platform decisions, production deploy without human approval.

## Package usage

For deep UI rules use `frontend-ai-os`. For deep API rules use `backend-ai-os`. This package coordinates both.
