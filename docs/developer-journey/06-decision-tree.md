# 06: Decision Tree

"I need to X" → read this, run this prompt, use this agent.

## Choose Your Path First

| I am building... | Path doc |
|------------------|----------|
| Frontend only | [frontend-only.md](../paths/frontend-only.md) |
| Backend only | [backend-only.md](../paths/backend-only.md) |
| Full stack | [full-stack.md](../paths/full-stack.md) |
| One specific task | [single-task.md](../paths/single-task.md) |

Always paste [project context](../../templates/project-context.md) for your repo before any agent prompt.

## Starting Out

| I need to… | Go to |
|------------|-------|
| Understand the system | [START-HERE.md](../START-HERE.md) |
| Onboard | [01-onboarding.md](01-onboarding.md) |
| Start a new project | [starter-kits/](../../starter-kits/) → kit `docs/setup.md` |
| Daily workflow | [02-daily-practices.md](02-daily-practices.md) |

## Requirements and Design

| I need to… | Go to |
|------------|-------|
| Clarify vague requirements | [prompts/ambiguity-resolution-prompt.md](../../prompts/ambiguity-resolution-prompt.md) |
| Write a feature spec | [templates/feature-spec.md](../../templates/feature-spec.md) + Stage 1 |
| Design system architecture | [prompts/architecture-prompt.md](../../prompts/architecture-prompt.md) |
| Write an ADR | [workflows/prompts/adr-authoring.md](../../workflows/prompts/adr-authoring.md) |
| Review architecture impact | Stage 2 playbook + [architecture-engineer](../../agents/architecture-engineer/) |

## Implementation

| I need to… | Go to |
|------------|-------|
| Build an API / service | [backend-engineer/prompts/primary.md](../../agents/backend-engineer/prompts/primary.md) |
| Build UI / frontend | [frontend-engineer/prompts/primary.md](../../agents/frontend-engineer/prompts/primary.md) |
| Full feature flow | [03-feature-delivery.md](03-feature-delivery.md) |
| Refactor safely | [prompts/refactor-prompt.md](../../prompts/refactor-prompt.md) |
| Best practices with AI | [05-coding-with-ai-os.md](05-coding-with-ai-os.md) |

## Quality and Review

| I need to… | Go to |
|------------|-------|
| Write test plan first | Stage 3 + [qa-engineer](../../agents/qa-engineer/) |
| Review a PR (general) | [prompts/code-review-prompt.md](../../prompts/code-review-prompt.md) |
| Security review a PR | [workflows/prompts/stage-05-security-review.md](../../workflows/prompts/stage-05-security-review.md) |
| QA sign-off | Stage 6 + [templates/qa-report.md](../../templates/qa-report.md) |
| Audit dependencies | [workflows/prompts/dependency-audit.md](../../workflows/prompts/dependency-audit.md) |

## Documentation and DX

| I need to… | Go to |
|------------|-------|
| Update API docs | [devrel-engineer](../../agents/devrel-engineer/) |
| Write integration guide | [devrel-engineer/prompts/primary.md](../../agents/devrel-engineer/prompts/primary.md) |
| Changelog entry | Stage 7 playbook |

## Production

| I need to… | Go to |
|------------|-------|
| Deploy to production | Stage 8 + [sre-engineer](../../agents/sre-engineer/) |
| Debug production issue | [prompts/debugging-prompt.md](../../prompts/debugging-prompt.md) |
| Hotfix | [workflows/hotfix.md](../../workflows/hotfix.md) |
| Incident response | [workflows/incident-response.md](../../workflows/incident-response.md) |
| Operate after ship | [04-ship-and-operate.md](04-ship-and-operate.md) |

## Standards Lookup

| Topic | Document |
|-------|----------|
| API design | [standards/api.md](../../standards/api.md) |
| Git / PR | [standards/git-workflow.md](../../standards/git-workflow.md) |
| Security | [standards/security.md](../../standards/security.md) |
| Testing | [standards/testing.md](../../standards/testing.md) |
| Observability | [standards/observability.md](../../standards/observability.md) |
| Database | [standards/database.md](../../standards/database.md) |
| Frontend | [standards/frontend.md](../../standards/frontend.md) |
| Errors | [standards/error-handling.md](../../standards/error-handling.md) |

## Contributing to AI-OS

| I need to… | Go to |
|------------|-------|
| Add a new prompt | [PROMPT-CONTRACT.md](../../prompts/PROMPT-CONTRACT.md) |
| Add a new agent | [CONTRIBUTING.md](../../CONTRIBUTING.md) + `scripts/scaffold-agent.sh` |
| Validate prompts | `scripts/validate-prompt-contract.sh` |
