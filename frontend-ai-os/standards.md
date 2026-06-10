# Standards

## Quality

- Strong typing where the project uses types. Avoid untyped escape hatches.
- Semantic HTML and accessible names (WCAG 2.1 AA minimum).
- Keyboard navigation and visible focus for interactive controls.
- Design tokens or shared variables for color, spacing, typography. Avoid magic values.

## Data and state

- Use the project's established data-fetching pattern. Do not introduce parallel fetching styles.
- Separate server-fetched data from ephemeral UI state.
- Handle stale, loading, and error paths explicitly.

## Forms

- Validate on client and server. Map server validation errors back to fields.
- Disable submit during in-flight requests. Show clear success and failure feedback.

## Security (UI)

- Sanitize user-generated content before render.
- Do not store secrets in client storage unless the project already does so by design.
- Avoid exposing internal errors verbatim to end users.

## Git discipline

- Small, reviewable commits. One concept per commit.
- Keep PRs focused. Prefer multiple PRs over one large change.
