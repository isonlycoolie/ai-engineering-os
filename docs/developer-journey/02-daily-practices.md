# 02 - Daily Practices

How you work every day inside the AI Engineering OS.

## Branching

Follow [standards/git-workflow.md](../../standards/git-workflow.md):

```
main          - production-ready; protected
develop       - integration branch
feature/*     - one branch per feature or task
hotfix/*      - emergency fixes from main
```

Create features with `scripts/new-feature.sh <name>` to get a branch and stub spec.

## Commits

Format: `<type>(<scope>): <description>`

Types: `feat`, `fix`, `refactor`, `test`, `docs`, `chore`, `perf`, `security`

Write the body explaining **why**, not what.

## Pull Requests

Every PR must:

- Reference the linked issue or task
- Explain the change and the reason
- Pass CI before review is requested
- Include completed checklists (human review, security if applicable, QA if applicable)
- Receive at least one human approval

Template: [templates/pr-description.md](../../templates/pr-description.md)

## When to Invoke Which Agent

| Situation | Agent / Prompt |
|-----------|----------------|
| Unclear requirements | [ambiguity-resolution-prompt](../../prompts/ambiguity-resolution-prompt.md) |
| New feature starting | Stage 1–3 workflows |
| Writing backend code | [backend-engineer/primary](../../agents/backend-engineer/prompts/primary.md) |
| Writing frontend code | [frontend-engineer/primary](../../agents/frontend-engineer/prompts/primary.md) |
| PR code review | [code-review-prompt](../../prompts/code-review-prompt.md) |
| PR security review | [stage-05-security-review](../../workflows/prompts/stage-05-security-review.md) |
| Production bug | [debugging-prompt](../../prompts/debugging-prompt.md) |
| Refactoring | [refactor-prompt](../../prompts/refactor-prompt.md) |
| Deploy | [stage-08](../../workflows/stage-08-production-deployment.md) |

Full map: [06-decision-tree.md](06-decision-tree.md)

## Daily Checklist

- [ ] Pull latest `develop` before starting work
- [ ] One concern per AI prompt session
- [ ] Attach context before asking for implementation (see [context-packing-guide](../../ai-collaboration/context-packing-guide.md))
- [ ] Run tests locally before pushing
- [ ] Complete [human-review-checklist](../../ai-collaboration/human-review-checklist.md) before merging agent output

## Hotfixes and Incidents

Skip the full eight-stage flow only for verified production emergencies:

- [workflows/hotfix.md](../../workflows/hotfix.md)
- [workflows/incident-response.md](../../workflows/incident-response.md)

Document retroactively. Schedule proper ADR or test coverage follow-up.

**Next:** [05-coding-with-ai-os.md](05-coding-with-ai-os.md) (before coding) or [03-feature-delivery.md](03-feature-delivery.md) (for features)
