# Frontend Standards

## Architecture

Feature-based structure per [frontend-engineer/architecture-rules.md](../agents/frontend-engineer/architecture-rules.md).

## Requirements

- TypeScript strict mode - no `any`
- Data fetching via TanStack Query only - not raw `useEffect`
- Forms: React Hook Form + Zod; validate client and server
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
