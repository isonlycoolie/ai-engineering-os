# Start Here

Welcome. This OS is a rulebook and prompt library. **You build in your project repo.** Agents follow the project context you provide.

## Choose Your Path

| I am building... | Go here |
|------------------|---------|
| **Frontend only** (UI, no API changes) | [paths/frontend-only.md](paths/frontend-only.md) |
| **Backend only** (API, no UI changes) | [paths/backend-only.md](paths/backend-only.md) |
| **Full stack** (API + UI) | [paths/full-stack.md](paths/full-stack.md) |
| **One specific task** (bug, review, deploy) | [paths/single-task.md](paths/single-task.md) |

First time? Read [adopt-in-your-project.md](adopt-in-your-project.md) (2 minutes).

**Using Cursor with AI?** Set up [MCP](mcp-setup.md) so agents auto-resolve prompts for your track.

## Philosophy

**AI accelerates execution. Humans own the architecture.**

## Every AI Session

1. Fill [templates/project-context.md](../templates/project-context.md) for **your** repo.
2. Attach [prompts/global-system-prompt.md](../prompts/global-system-prompt.md).
3. Attach the role or workflow prompt for your task.
4. Attach source files from your project.

## Repository Map (OS library)

| Path | Purpose |
|------|---------|
| [docs/paths/](paths/) | Role-based entry paths |
| [docs/adopt-in-your-project.md](adopt-in-your-project.md) | Wire OS to your project |
| [agents/](../agents/) | Role definitions and prompts |
| [workflows/](../workflows/) | Stage playbooks |
| [standards/](../standards/) | Engineering rules |
| [starter-kits/](../starter-kits/) | New project templates |

## Full Feature Delivery (reference)

Eight stages with human checkpoints. Use when delivering a complete feature:

| Stage | Playbook |
|-------|----------|
| 1. Requirements | [stage-01](../workflows/stage-01-requirement-clarity.md) |
| 2. Architecture | [stage-02](../workflows/stage-02-architecture-review.md) |
| 3. Test spec | [stage-03](../workflows/stage-03-test-specification.md) |
| 4. Implementation | [stage-04](../workflows/stage-04-implementation.md) |
| 5. Security | [stage-05](../workflows/stage-05-security-review.md) |
| 6. QA | [stage-06](../workflows/stage-06-qa-verification.md) |
| 7. Docs | [stage-07](../workflows/stage-07-documentation.md) |
| 8. Deploy | [stage-08](../workflows/stage-08-production-deployment.md) |

Detail: [developer-journey/03-feature-delivery.md](developer-journey/03-feature-delivery.md).

## Developer Journey

| Doc | When |
|-----|------|
| [01-onboarding.md](developer-journey/01-onboarding.md) | First day |
| [02-daily-practices.md](developer-journey/02-daily-practices.md) | Every day |
| [05-coding-with-ai-os.md](developer-journey/05-coding-with-ai-os.md) | Before AI-assisted coding |
| [06-decision-tree.md](developer-journey/06-decision-tree.md) | "I need to X" lookup |

## Prompts

Every prompt follows [PROMPT-CONTRACT](../prompts/PROMPT-CONTRACT.md). Validate with `scripts/validate-prompt-contract.ps1`.

Vision doc: [ai-engineering-os.md](../ai-engineering-os.md) (v1.1).
