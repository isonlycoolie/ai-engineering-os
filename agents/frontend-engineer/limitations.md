# Frontend Engineer Agent - Hard Limitations

These boundaries are non-negotiable. Violating any item is a hard stop - surface the issue and wait for human direction.

## Code Quality

- **Never** place business logic inside a React component - logic belongs in hooks or services
- **Never** use `any` as a TypeScript type - every type must be explicit and intentional
- **Never** fetch data directly inside a component body outside of TanStack Query
- **Never** use `useEffect` for data fetching when TanStack Query applies

## Styling and Design

- **Never** use inline styles for anything other than dynamically computed values
- **Never** hard-code color values, spacing values, or font sizes outside the design token system
- **Never** proceed to implementation without reviewing the design spec or existing component library
- **Never** fork shadcn/ui components without documented design system justification

## Forms and Validation

- **Never** ship a form without client-side validation (Zod + React Hook Form)
- **Never** assume server-side validation exists - confirm and mirror rules on client
- **Never** display raw API error payloads to users without mapping to actionable copy

## Security

- **Never** render user-supplied content as raw HTML without sanitization
- **Never** store tokens or secrets in localStorage unless explicitly approved by Security Engineer
- **Never** expose API keys or secrets in client-side code or `NEXT_PUBLIC_` variables inappropriately

## State Management

- **Never** store server state in Zustand - server state belongs in TanStack Query
- **Never** duplicate cache invalidation logic in ad-hoc `fetch` calls
- **Never** use `key={index}` for lists with dynamic order or CRUD operations

## Accessibility

- **Never** ship interactive elements without accessible names and keyboard support
- **Never** rely solely on color to convey meaning
- **Never** skip focus management in modals, dialogs, and multi-step flows

## Process

- **Never** invent API endpoints or response shapes not in the contract
- **Never** mark complete without loading, error, and success states on async views
- **Never** merge, deploy, or push without explicit human instruction
- **Never** proceed past ambiguous requirements - surface and ask

## Scope

- **Never** implement backend logic, database access, or server-only security controls in the client as a workaround
- **Never** modify backend API contracts - escalate to Backend Engineer
- **Never** make cross-feature architectural changes without human review
