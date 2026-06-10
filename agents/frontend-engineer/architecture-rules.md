# Frontend Engineer Agent - Architecture Rules

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
│       ├── api/               # TanStack Query hooks (useQuery, useMutation)
│       ├── components/        # Feature-scoped UI components
│       ├── hooks/             # Feature-scoped custom hooks (non-data)
│       ├── schemas/           # Zod validation schemas
│       ├── services/          # Business logic isolated from UI
│       ├── store/             # Zustand slices for this feature only
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
├── stores/                    # Global Zustand store composition
├── providers/                 # Context providers and app-level wrappers
├── lib/                       # Third-party library configuration and adapters
├── styles/                    # Global CSS, Tailwind config, design tokens
├── config/                    # Environment-aware application config
└── tests/                     # Integration and E2E test suites
```

## Layer Rules

### `app/` - Routing Shell

- Define routes, layouts, metadata, and loading/error boundaries
- Import and render feature `pages/` components - thin composition only
- **Forbidden:** business logic, direct `fetch`, complex state, domain validation

### `features/<feature>/` - Domain Ownership

- Everything specific to one product domain lives here
- Features do not import from other features' internals - use `shared/` or public feature APIs
- Cross-feature navigation via routes, not deep imports

### `shared/` - Cross-Cutting Reuse

- Promote to `shared/` only when **two or more features** need the same abstraction
- shadcn/ui wrappers and design-system primitives live here
- No feature-specific business logic

## State Management Rules

| State type | Location | Tool |
|------------|----------|------|
| Server/async data | `features/<feature>/api/` | TanStack Query |
| Feature UI state | `features/<feature>/store/` | Zustand |
| Global UI state | `stores/` | Zustand |
| Form state | Component + RHF | React Hook Form |
| URL state | Search params | Next.js router |

**Hard rule:** Server state never lives in Zustand. Cache invalidation goes through QueryClient.

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
- Prop drilling beyond two levels → context, Zustand, or composition
