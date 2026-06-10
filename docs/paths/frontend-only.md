# Frontend-Only Path

For engineers building UI with no backend changes in scope.

**Time to first prompt: under 10 minutes.**

## 1. Adopt the OS in your project

[adopt-in-your-project.md](../adopt-in-your-project.md) (reference or `install-ai-os`).

## 2. Read these only (5 files)

1. [templates/project-context.md](../../templates/project-context.md)
2. [ai-collaboration/prompting-rules.md](../../ai-collaboration/prompting-rules.md)
3. [ai-collaboration/human-review-checklist.md](../../ai-collaboration/human-review-checklist.md)
4. [agents/frontend-engineer/role.md](../../agents/frontend-engineer/role.md)
5. [standards/frontend.md](../../standards/frontend.md)

Skip backend agent docs unless your task changes APIs.

## 3. Starter kit

[starter-kits/nextjs-enterprise/](../../starter-kits/nextjs-enterprise/) then `docs/setup.md`.

## 4. Stages to run

| Stage | Run? | Notes |
|-------|------|-------|
| 1 Requirement clarity | Yes | UI acceptance criteria only |
| 2 Architecture | If new routes/features affect app structure | Skip ADR for pure UI |
| 3 Test spec | Yes | Component + E2E for critical flows |
| 4 Implementation | Yes | **frontend-engineer** only |
| 5 Security review | Yes | XSS, auth UI, client data handling |
| 6 QA verification | Yes | |
| 7 Documentation | If public UI or integration guide | |
| 8 Deploy | If you own frontend deploy | Else hand to platform team |

## 5. Agents and prompts

| Task | Prompt |
|------|--------|
| Implement UI | [frontend-engineer/prompts/primary.md](../../agents/frontend-engineer/prompts/primary.md) |
| Review UI PR | [frontend-engineer/prompts/review.md](../../agents/frontend-engineer/prompts/review.md) |
| Security review | [stage-05-security-review.md](../../workflows/prompts/stage-05-security-review.md) |
| Clarify requirements | [ambiguity-resolution-prompt.md](../../prompts/ambiguity-resolution-prompt.md) |

## MCP (recommended)

Instead of manual prompt paste, use the MCP server:

```
aios_resolve_task_context({ track: "frontend", taskType: "implement", ticket: "UI-88" })
```

Setup: [mcp-setup.md](../mcp-setup.md)

Manual fallback: [global-system-prompt.md](../../prompts/global-system-prompt.md) + filled project context.

## 6. Checklist before PR

[agents/frontend-engineer/checklists/pre-delivery.md](../../agents/frontend-engineer/checklists/pre-delivery.md)

## 7. Git discipline

[standards/git-commit-discipline.md](../../standards/git-commit-discipline.md) (150 lines per commit, 400 per PR).

**Next:** [05-coding-with-ai-os.md](../developer-journey/05-coding-with-ai-os.md)
