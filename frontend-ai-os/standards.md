# Standards

# Frontend Standards

## Architecture

Feature-based structure per [frontend-engineer/architecture-rules.md](../agents/frontend-engineer/architecture-rules.md).

## Requirements

- TypeScript strict mode - no `any`
- Data fetching via the project's server-state library only - not raw `useEffect`
- Forms: the project's form and validation stack; validate client and server
- Accessibility: WCAG 2.1 AA minimum
- Design tokens for color, spacing, typography - no magic values
- User content never rendered as raw HTML without sanitization

## Performance

- Lazy load routes and heavy components
- Define performance budgets for LCP and bundle size
- Loading, error, empty states for every async view

## Agent Invocation

| Task | Agent |
|------|-------|
| Feature UI | [frontend-engineer/prompts/primary.md](../agents/frontend-engineer/prompts/primary.md) |
| A11y review | [frontend-engineer/prompts/review.md](../agents/frontend-engineer/prompts/review.md) |
| API integration | [standards/api.md](api.md) |

## Architecture

All frontend code follows a **feature-based architecture**. There are no exceptions.

See also [`standards/frontend.md`](../../standards/frontend.md).

## Directory Structure

```
src/
│
├── app/                       # Next.js App Router - routes only, no business logic
│   ├── (auth)/                # Route groups as needed
│   ├── (dashboard)/
│   ├── layout.tsx
│   ├── page.tsx
│   └── api/                   # Route handlers only when BFF pattern is approved
│
├── features/                  # One folder per product domain
│   └── <feature>/
│       ├── api/               # the project's server-state library hooks (useQuery, useMutation)
│       ├── components/        # Feature-scoped UI components
│       ├── hooks/             # Feature-scoped custom hooks (non-data)
│       ├── schemas/           # Zod validation schemas
│       ├── services/          # Business logic isolated from UI
│       ├── store/             # the project's client-state store slices for this feature only
│       ├── types/             # TypeScript interfaces and types
│       └── pages/             # Page-level components wired together
│
├── shared/
│   ├── components/            # Reusable UI primitives (buttons, layouts, data-display)
│   ├── hooks/                 # Global hooks (useDebounce, useMediaQuery)
│   ├── utils/                 # Pure utility functions
│   ├── services/              # Shared abstractions (http client, analytics)
│   ├── types/                 # Global TypeScript types
│   ├── constants/             # Application-wide constants
│   └── validations/           # Shared Zod schemas
│
├── stores/                    # Global the project's client-state store store composition
├── providers/                 # Context providers and app-level wrappers
├── lib/                       # Third-party library configuration and adapters
├── styles/                    # Global CSS, utility-first styling config, design tokens
├── config/                    # Environment-aware application config
└── tests/                     # Integration and E2E test suites
```

## Layer Rules

### `app/` - Routing Shell

- Define routes, layouts, metadata, and loading/error boundaries
- Import and render feature `pages/` components - thin composition only
- **Forbidden:** business logic, direct `fetch`, complex state, domain validation

### feature-scoped modules - Domain Ownership

- Everything specific to one product domain lives here
- Features do not import from other features' internals - use `shared/` or public feature APIs
- Cross-feature navigation via routes, not deep imports

### `shared/` - Cross-Cutting Reuse

- Promote to `shared/` only when **two or more features** need the same abstraction
- the design system wrappers and design-system primitives live here
- No feature-specific business logic

## State Management Rules

| State type | Location | Tool |
|------------|----------|------|
| Server/async data | `features/<feature>/api/` | the project's server-state library |
| Feature UI state | `features/<feature>/store/` | the project's client-state store |
| Global UI state | `stores/` | the project's client-state store |
| Form state | Component + RHF | React Hook Form |
| URL state | Search params | Next.js router |

**Hard rule:** Server state never lives in the project's client-state store. Cache invalidation goes through QueryClient.

## Data Fetching Pattern

```typescript
// features/orders/api/use-orders.ts
export function useOrders(filters: OrderFilters) {
  return useQuery({
    queryKey: ['orders', filters],
    queryFn: () => ordersService.list(filters),
  });
}
```

- Query keys are hierarchical and include all filter dependencies
- Mutations invalidate affected query keys explicitly
- Optimistic updates only with documented rollback on failure

## Component Rules

- Presentational components receive data via props - no embedded fetching
- Container/page components wire hooks to presentational children
- Max ~200 lines per component file - split when exceeded
- Prop drilling beyond two levels → context, the project's client-state store, or composition

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
