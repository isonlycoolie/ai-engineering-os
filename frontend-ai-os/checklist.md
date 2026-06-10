# Checklist

# Frontend Engineer - Pre-Delivery Checklist

Complete every item before submitting implementation for human review. Flag any unchecked item with explanation in the implementation summary.

## Architecture

- [ ] Code placed per feature-based structure in [`architecture-rules.md`](../architecture-rules.md)
- [ ] No business logic in `app/` route files - composition only
- [ ] Feature code scoped to feature-scoped modules - no cross-feature deep imports
- [ ] Shared abstractions promoted to `shared/` only when used by 2+ features
- [ ] Component files under 200 lines (or split with justification)

## TypeScript and Code Quality

- [ ] TypeScript strict mode - no `any` types
- [ ] Business logic in hooks or services - not in component bodies
- [ ] No banned anti-patterns from [`anti-patterns.md`](../anti-patterns.md)
- [ ] Non-obvious decisions annotated with inline comments

## Data and State

- [ ] Server data fetched via the project's server-state library only - no `useEffect` fetching
- [ ] Server state not stored in the project's client-state store
- [ ] Query keys hierarchical and include filter dependencies
- [ ] Mutations invalidate affected query keys
- [ ] Loading, error, and success states on every async view
- [ ] Empty state provided where data can legitimately be absent
- [ ] Stable list keys - unique entity IDs, not array index

## API Integration

- [ ] Types aligned with backend API contract / OpenAPI
- [ ] Error responses mapped to user-actionable UI messages
- [ ] Auth requirements handled per contract (headers, cookies, redirects)
- [ ] No invented endpoints or undocumented response shapes

## Forms

- [ ] the project's form and validation stack validation on all forms
- [ ] Client validation mirrors server rules
- [ ] Server validation errors displayed on correct fields
- [ ] Submit disabled during in-flight mutation with loading indicator

## Styling and Design

- [ ] the design system used where applicable
- [ ] utility-first styling for styling - no inline styles except dynamic values
- [ ] Design tokens for color, spacing, typography - no magic values
- [ ] Responsive layout verified at mobile, tablet, and desktop breakpoints
- [ ] Matches design spec or documented approved deviations

## Accessibility (WCAG 2.1 AA)

- [ ] Semantic HTML elements used appropriately
- [ ] All interactive elements have accessible names
- [ ] Keyboard navigation works for all interactive flows
- [ ] Focus management correct in modals, dialogs, and wizards
- [ ] Color contrast meets AA minimum
- [ ] `prefers-reduced-motion` respected for animations
- [ ] User content never rendered as raw HTML without sanitization

## Performance

- [ ] Heavy components and routes lazy-loaded where appropriate
- [ ] Images use `optimized image components` with appropriate sizing
- [ ] No unnecessary re-renders from unstable object/array literals in props
- [ ] New dependencies justified and bundle impact noted

## Security

- [ ] No secrets or inappropriate values in `public client env prefixes` env vars
- [ ] User-generated content sanitized before HTML rendering
- [ ] Tokens stored per approved security pattern only

## Testing

- [ ] Unit tests for hooks and services (happy path + failure modes)
- [ ] Component or integration tests for critical UI behavior
