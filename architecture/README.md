# Architecture

System design patterns and Architecture Decision Records (ADRs).

## When ADRs Are Required

Write an ADR before proceeding when the change:

- Adds a new service, database, or message broker
- Introduces a new external dependency
- Changes API versioning or breaking contracts
- Affects authentication or authorization architecture
- Splits or merges service boundaries

## ADR Location

```
architecture/decisions/ADR-<number>-<short-title>.md
```

Use [decisions/ADR-000-template.md](decisions/ADR-000-template.md) or `scripts/scaffold-adr.sh`.

## Patterns

| Pattern | Document |
|---------|----------|
| Modular monolith | [patterns/modular-monolith.md](patterns/modular-monolith.md) |
| Event-driven | [patterns/event-driven.md](patterns/event-driven.md) |
| API versioning | [patterns/api-versioning.md](patterns/api-versioning.md) |

## Workflow

1. Stage 2: [workflows/stage-02-architecture-review.md](../workflows/stage-02-architecture-review.md)
2. Prompt: [workflows/prompts/adr-authoring.md](../workflows/prompts/adr-authoring.md)
3. Agent: [architecture-engineer](../agents/architecture-engineer/)

No structural decision proceeds without human-reviewed ADR.
