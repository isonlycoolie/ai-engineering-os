# Project Context

Paste this block at the top of every AI agent session. Fill in all fields before invoking an agent.

```markdown
## Project context

| Field | Value |
|-------|-------|
| Repository | [your-repo-name] |
| Project root | [e.g. ./ or apps/web/] |
| Stack | [e.g. Next.js 14, TypeScript, PostgreSQL] |
| Track | frontend / backend / fullstack |
| Ticket | [e.g. AUTH-42] |
| Branch | [e.g. feature/AUTH-42-refresh-token] |

### Task summary
[One to three sentences: what you are building or fixing]

### Acceptance criteria
- [ ] [Testable criterion 1]
- [ ] [Testable criterion 2]

### Files in scope
- [path/to/file1.ts]
- [path/to/file2.ts]

### Standards in use
- [Path to API standard, or .ai-os/standards/api.md if installed]
- [Link to ADR if applicable]

### Out of scope
- [What this task must NOT touch]
```

## Example (frontend feature)

```markdown
## Project context

| Field | Value |
|-------|-------|
| Repository | customer-portal |
| Project root | apps/web/ |
| Stack | Next.js 14, TypeScript, TanStack Query, shadcn/ui |
| Track | frontend |
| Ticket | UI-88 |
| Branch | feature/UI-88-settings-page |

### Task summary
Add a Settings page with profile edit form. Uses existing /v1/users/me API.

### Acceptance criteria
- [ ] Settings route renders at /settings
- [ ] Form validates email with Zod
- [ ] Loading, error, and success states handled

### Files in scope
- apps/web/src/features/settings/
- apps/web/src/app/settings/page.tsx

### Standards in use
- .ai-os/standards/frontend.md

### Out of scope
- Backend API changes
- Auth provider changes
```
