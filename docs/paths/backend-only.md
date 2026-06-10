# Backend-Only Path

For engineers building APIs and services with no frontend changes in scope.

## 1. Adopt the OS in your project

[adopt-in-your-project.md](../adopt-in-your-project.md).

## 2. Read these only (5 files)

1. [templates/project-context.md](../../templates/project-context.md)
2. [ai-collaboration/prompting-rules.md](../../ai-collaboration/prompting-rules.md)
3. [ai-collaboration/human-review-checklist.md](../../ai-collaboration/human-review-checklist.md)
4. [agents/backend-engineer/role.md](../../agents/backend-engineer/role.md)
5. [standards/api.md](../../standards/api.md)

Also skim [standards/database.md](../../standards/database.md) and [standards/security.md](../../standards/security.md).

Skip frontend architecture unless your task returns UI-facing contracts.

## 3. Starter kit

Pick one:

- [fastapi-enterprise](../../starter-kits/fastapi-enterprise/)
- [django-enterprise](../../starter-kits/django-enterprise/)
- [microservice-template](../../starter-kits/microservice-template/)

## 4. Stages to run

| Stage | Run? | Notes |
|-------|------|-------|
| 1 Requirement clarity | Yes | API contract + acceptance criteria |
| 2 Architecture | Yes if new service, DB, or dependency | ADR required for structural changes |
| 3 Test spec | Yes | Unit + integration tests |
| 4 Implementation | Yes | **backend-engineer** only |
| 5 Security review | Yes | Auth, injection, secrets |
| 6 QA verification | Yes | |
| 7 Documentation | Yes | OpenAPI + changelog |
| 8 Deploy | Yes if you own deploy | **sre-engineer** checklist |

## 5. Agents and prompts

| Task | Prompt |
|------|--------|
| Implement API | [backend-engineer/prompts/primary.md](../../agents/backend-engineer/prompts/primary.md) |
| Review API PR | [backend-engineer/prompts/review.md](../../agents/backend-engineer/prompts/review.md) |
| Design API | [architecture-prompt.md](../../prompts/architecture-prompt.md) |
| Security review | [stage-05-security-review.md](../../workflows/prompts/stage-05-security-review.md) |
| Debug production | [debugging-prompt.md](../../prompts/debugging-prompt.md) |

Always attach: global system prompt + project context.

## 6. Checklist before PR

[agents/backend-engineer/checklists/pre-delivery.md](../../agents/backend-engineer/checklists/pre-delivery.md)

## 7. Git discipline

[agents/shared/git-workflow-instructions.md](../../agents/shared/git-workflow-instructions.md) (inherit on every task).

**Next:** [05-coding-with-ai-os.md](../developer-journey/05-coding-with-ai-os.md)
