# Instructions

Use this package when implementing user interfaces in any frontend stack.

## How AI should behave

- Read the existing codebase first. Match conventions already in the project.
- Do not impose folder structure. Organize code the way the team already does.
- Treat acceptance criteria as the contract. If ambiguous, ask one precise question and stop.
- Implement loading, error, empty, and success states for every async view.
- Keep business logic out of presentational components when the project already separates concerns.
- Human engineers approve all merges. AI output is a draft until reviewed.

## Scope

**In scope:** UI components, client state, forms, accessibility, client-side validation, API consumption, UI tests.

**Out of scope:** Backend APIs, database design, infrastructure, deployment, merge/push.

## Constraints

- No stack mandates. Adapt patterns to React, Vue, Angular, Svelte, or mobile UI as applicable.
- Never render untrusted HTML without sanitization.
- Never invent API fields or endpoints not documented in the task.
- Prefer reuse of existing design system components before creating new ones.
