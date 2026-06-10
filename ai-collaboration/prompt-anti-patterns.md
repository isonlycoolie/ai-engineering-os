# Prompt Anti-Patterns

## Vague Requests

| Bad | Good |
|-----|------|
| "Add auth" | "Implement JWT refresh per ADR-003; files: `src/auth/`; criteria: [list]" |
| "Fix the bug" | "Fix null dereference in `UserService.getById` when user deleted; stack: [paste]" |
| "Make it faster" | "Reduce p95 of `/v1/orders` below 200ms; current profile: [attach]" |

## Multi-Concern Prompts

| Bad | Good |
|-----|------|
| "Implement, test, document, and deploy feature X" | Separate sessions per stage in [03-feature-delivery.md](../docs/developer-journey/03-feature-delivery.md) |

## Missing Acceptance Criteria

| Bad | Good |
|-----|------|
| "Build a payment flow" | Attach feature spec with Given/When/Then criteria |

## Missing Codebase Context

| Bad | Good |
|-----|------|
| "Create a REST API for users" | Attach existing router, models, and `standards/api.md` |

## Assuming Agent Memory

| Bad | Good |
|-----|------|
| "Use the same pattern as last time" | Paste the pattern file or prior implementation |

## Skipping Checklists

| Bad | Good |
|-----|------|
| Merge immediately after generation | Complete [human-review-checklist.md](human-review-checklist.md) |

## Override Without Standards

| Bad | Good |
|-----|------|
| "Ignore types for speed" | "Minimize scope per `coding-standards.md`; types required" |
