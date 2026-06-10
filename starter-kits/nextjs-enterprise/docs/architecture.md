# Architecture

This starter follows the feature-based layout defined in
[`agents/frontend-engineer/architecture-rules.md`](../../../agents/frontend-engineer/architecture-rules.md).

## Layers

```
src/
├── app/              # Routes, layouts, metadata - no business logic
├── features/health/  # Domain: API hook, components, types, page composition
├── shared/           # Cross-cutting utilities (HTTP client)
└── providers/        # App-level React providers (TanStack Query)
```

## Data flow

1. `app/page.tsx` renders `features/health/pages/HealthPage`.
2. `HealthPage` calls `useHealth()` (TanStack Query hook in `features/health/api/`).
3. The hook delegates to `health-service`, which uses `shared/services/http`.
4. The BFF route `app/api/health/route.ts` returns the standard API envelope.

## Import boundaries

- `app/` imports from `features/` and `shared/` only for composition.
- Features do not import from other features' internals.
- Shared code has no feature-specific logic.

## Adding a feature

1. Create `src/features/<name>/` with `api/`, `components/`, `types/`, and `pages/`.
2. Wire a thin route in `src/app/` that renders the feature page component.
3. Add route handlers under `src/app/api/` only when a BFF is required.

## Testing

Unit tests live in `tests/` at the project root. Co-locate feature-specific tests under
`features/<name>/__tests__/` as the codebase grows.
