# Frontend Engineer Agent - Anti-Patterns

The following patterns are explicitly banned. Flag and propose an alternative before proceeding.

## State and Data

| Anti-pattern | Why it fails | Alternative |
|--------------|--------------|-------------|
| **useEffect for data fetching** | Race conditions, no cache, duplicate requests | TanStack Query hooks in `features/<feature>/api/` |
| **Server state in Zustand** | Stale data, double source of truth | TanStack Query with explicit invalidation |
| **Fetching in component body** | Untestable, inconsistent loading/error handling | Custom query hooks |
| **Prop drilling beyond two levels** | Fragile, hard to refactor | Context, Zustand, or component composition |

## Components

| Anti-pattern | Why it fails | Alternative |
|--------------|--------------|-------------|
| **Component files >200 lines** | Hard to test and reason about | Split presentational vs container; extract hooks |
| **Business logic in components** | Untestable, duplicated across views | `hooks/` and `services/` |
| **God components** | One file handles fetch, validate, render, navigate | Layered architecture per feature folder |
| **key={index} in lists** | Incorrect reconciliation, state bugs on reorder | Stable unique IDs from domain entities |

## UI States

| Anti-pattern | Why it fails | Alternative |
|--------------|--------------|-------------|
| **Unhandled loading/error states** | Broken UX, silent failures | Loading skeleton, error boundary/retry, empty state |
| **Infinite spinners** | No timeout or error path | Query `error` and `isLoading` with fallback UI |
| **Generic "Something went wrong"** | User cannot recover | Map API error codes to actionable messages |

## Styling

| Anti-pattern | Why it fails | Alternative |
|--------------|--------------|-------------|
| **Inline styles for static layout** | Inconsistent with design system | Tailwind utility classes and tokens |
| **Magic color/spacing values** | Theme breaks, dark mode failures | Design tokens in Tailwind config |
| **Global CSS overrides** | Unpredictable cascade | Component-scoped Tailwind, shadcn variants |

## Forms

| Anti-pattern | Why it fails | Alternative |
|--------------|--------------|-------------|
| **Uncontrolled forms without validation** | Bad data reaches API | React Hook Form + Zod |
| **Submit-only validation** | Poor UX, wasted round-trips | Field-level validation on blur/change |
| **Ignoring server validation errors** | Client/server drift | Map server error envelope to form fields |

## Performance

| Anti-pattern | Why it fails | Alternative |
|--------------|--------------|-------------|
| **Importing heavy libs in root layout** | Bundle bloat | Dynamic import, route-level code splitting |
| **Re-render storms** | Janky UI | Memoization where measured; stable query keys |
| **Unoptimized images** | Poor LCP | `next/image` with sizes and priority |

## Accessibility

| Anti-pattern | Why it fails | Alternative |
|--------------|--------------|-------------|
| **div onClick without keyboard** | WCAG violation | `button` or proper role + tabIndex + handlers |
| **Missing form labels** | Screen reader failure | Explicit `<label>` or `aria-label` |
| **Color-only status indicators** | Inaccessible to color-blind users | Icon + text + color |
| **Ignoring prefers-reduced-motion** | Vestibular accessibility failure | Conditional Framer Motion |

## Architecture

| Anti-pattern | Why it fails | Alternative |
|--------------|--------------|-------------|
| **Business logic in app/ routes** | Violates App Router boundaries | Feature `pages/` and `services/` |
| **Cross-feature deep imports** | Tight coupling | `shared/` abstractions or route navigation |
| **Duplicate HTTP clients** | Inconsistent auth and error handling | `shared/services/http` |

## Testing

| Anti-pattern | Why it fails | Alternative |
|--------------|--------------|-------------|
| **Testing implementation details** | Brittle tests | Assert user-visible behavior |
| **Snapshot-only tests** | False confidence | Interaction and state assertions |
| **Skipping a11y checks** | Production accessibility debt | axe-core in CI, manual keyboard pass |
