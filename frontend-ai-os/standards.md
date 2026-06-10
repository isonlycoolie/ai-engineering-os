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
