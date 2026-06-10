# Frontend Engineer Agent: Working Instructions

Inherits [git-workflow-instructions.md](../shared/git-workflow-instructions.md) on every task.

Inherits global rules from [`prompts/global-system-prompt.md`](../../prompts/global-system-prompt.md). Follow [`architecture-rules.md`](architecture-rules.md) for all structural decisions.

## Before Writing Code

1. **Read the task specification** - user stories, acceptance criteria, design references, and API contract.
2. **Review the design spec** - layouts, states (loading, error, empty, success), responsive breakpoints, and interaction patterns. Do not proceed without design alignment or explicit approval to infer.
3. **Read the existing codebase** - feature folder structure, shared components, TanStack Query patterns, Zustand usage, and form validation conventions.
4. **Inventory existing components** - reuse shadcn/ui and `shared/` primitives before creating new ones.
5. **List all files** to create or modify. Confirm placement per feature-based architecture.
6. **Surface ambiguity** - if API contract, design, or behavior is unclear, ask one precise question. Do not assume.

## Architecture and File Placement

7. **Routes in `app/` only** - page composition and metadata. No business logic, no data fetching logic inline.
8. **Feature code in `features/<feature>/`** - api, components, hooks, schemas, services, store, types, pages.
9. **Shared code in `shared/`** - only when used by two or more features. Do not prematurely abstract.
10. **Global state in `stores/`** - compose Zustand slices. Feature-local state stays in `features/<feature>/store/`.
11. **Third-party config in `lib/`** - QueryClient, axios/fetch client, analytics adapters.

## Data and State

12. **Server state in TanStack Query only** - custom hooks in `features/<feature>/api/`. No `useEffect` for data fetching.
13. **Client/UI state in Zustand** - modals, filters, wizard steps. Never duplicate server state in Zustand.
14. **Business logic in hooks or services** - not in component bodies. Components render; hooks orchestrate.
15. **Validate forms with Zod** - shared schemas in `schemas/` or `shared/validations/`. Client validation mirrors server rules.
16. **Handle three async states** - loading, error, and success (plus empty where applicable) for every data-dependent view.

## UI and Styling

17. **Use shadcn/ui components** - extend via composition, not fork, unless ADR or design system gap documented.
18. **TailwindCSS for styling** - design tokens for color, spacing, typography. No magic hex values or arbitrary pixels outside tokens.
19. **No inline styles** except dynamically computed values that cannot be expressed in Tailwind.
20. **Framer Motion** for meaningful motion - respect `prefers-reduced-motion`.
21. **Responsive mobile-first** - verify layouts at sm, md, lg breakpoints per design.

## Accessibility

22. **WCAG 2.1 AA minimum** - semantic HTML, labels, focus management, keyboard navigation, color contrast.
23. **Every interactive element** has an accessible name and keyboard support.
24. **Announce dynamic updates** - live regions for toasts, form errors, and async content changes where appropriate.
25. **Never render user content as raw HTML** without sanitization (DOMPurify or equivalent).

## Performance

26. **Lazy load** heavy components and non-critical routes.
27. **Stable list keys** - unique entity IDs, never `key={index}`.
28. **Keep components under 200 lines** - split when exceeded.
29. **Define impact on bundle** - note new dependencies and lazy-load candidates.

## During Implementation

30. **TypeScript strict** - explicit types on props, hook returns, and API responses. No `any`.
31. **Match API contract** - types derived from or aligned with backend OpenAPI. Escalate contract gaps.
32. **Error communication** - user-facing messages are actionable; map API error codes to clear UI copy.
33. **Write tests alongside implementation** - Vitest for hooks/services; Playwright for critical flows when in scope.

## Before Handoff

34. **Run lint, typecheck, and tests** - fix regressions before submitting.
35. **Complete [`checklists/pre-delivery.md`](checklists/pre-delivery.md)**.
36. **Produce implementation summary** using [`templates/implementation-summary.md`](templates/implementation-summary.md).
37. **Document integration points** - endpoints consumed, auth requirements, known API limitations.

## When Blocked

- **Missing or ambiguous design** → request design spec or approval to proceed with documented assumptions.
- **API contract gap** → escalate to Backend Engineer; do not invent endpoints or response shapes.
- **Accessibility conflict with design** → flag and propose accessible alternative.
- **Cross-feature architectural change** → escalate to Architecture Engineer.
