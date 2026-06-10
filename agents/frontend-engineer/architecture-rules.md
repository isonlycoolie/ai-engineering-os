
## Import Boundaries

```
app/           → features/, shared/, providers/
features/X/    → shared/, lib/, config/ - NOT features/Y/ internals
shared/        → lib/, config/ - NOT features/
lib/           → external packages only
```

## Naming Conventions

| Artifact | Convention | Example |
|----------|------------|---------|
| Feature folder | kebab-case | `user-settings/` |
| Components | PascalCase file and export | `OrderSummary.tsx` |
| Hooks | camelCase with `use` prefix | `useOrderSummary.ts` |
| Services | camelCase | `ordersService.ts` |
| Types | PascalCase | `Order`, `OrderFilters` |
| Query keys | tuple arrays | `['orders', { status }]` |

## Testing Placement

| Test type | Location |
|-----------|----------|
| Hook/service unit tests | Adjacent `*.test.ts` or `features/<feature>/__tests__/` |
| Component tests | Adjacent to component or feature `__tests__/` |
| E2E | `tests/e2e/` |

## Anti-Architecture (Forbidden)

- Business logic in `app/` route files
- `useEffect` + `fetch` for server data
- Feature A importing `features/B/components/internal-widget`
- Global CSS overrides that break design tokens
- Duplicate API clients per feature - use `shared/services/http`
