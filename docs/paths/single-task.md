# Single-Task Path

Minimal path for one-off work: bug fix, refactor, security review, deploy, docs.

Fill [project context](../../templates/project-context.md) first. Then pick your task:

## Bug fix (production)

| Step | Resource |
|------|----------|
| 1 | [debugging-prompt.md](../../prompts/debugging-prompt.md) |
| 2 | Role prompt (backend or frontend) for the fix |
| 3 | [hotfix.md](../../workflows/hotfix.md) if production emergency |
| 4 | [human-review-checklist.md](../../ai-collaboration/human-review-checklist.md) |

Skip stages 1-3 unless the fix changes behavior spec.

## Refactor

| Step | Resource |
|------|----------|
| 1 | [refactor-prompt.md](../../prompts/refactor-prompt.md) |
| 2 | [git-commit-discipline.md](../../standards/git-commit-discipline.md) (small commits) |

## Security review (PR)

| Step | Resource |
|------|----------|
| 1 | [stage-05-security-review.md](../../workflows/prompts/stage-05-security-review.md) |
| 2 | PR diff + project context |

No implementation in this workflow.

## Code review (general)

[prompts/code-review-prompt.md](../../prompts/code-review-prompt.md)

## Write tests only

[qa-engineer/prompts/primary.md](../../agents/qa-engineer/prompts/primary.md) + [stage-03-test-specification.md](../../workflows/prompts/stage-03-test-specification.md)

## Update docs only

[devrel-engineer/prompts/primary.md](../../agents/devrel-engineer/prompts/primary.md)

## Deploy to production

[stage-08-production-deployment.md](../../workflows/prompts/stage-08-production-deployment.md) + [sre-engineer/checklists/pre-production.md](../../agents/sre-engineer/checklists/pre-production.md)

## Clarify vague ticket

[ambiguity-resolution-prompt.md](../../prompts/ambiguity-resolution-prompt.md)

## Dependency audit

[dependency-audit.md](../../workflows/prompts/dependency-audit.md)

## Always attach

1. Project context (filled)
2. [global-system-prompt.md](../../prompts/global-system-prompt.md)
3. Task-specific prompt from table above
4. Relevant files from **your** repository

More tasks: [06-decision-tree.md](../developer-journey/06-decision-tree.md)
