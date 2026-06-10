# AI-Augmented Engineering Operating System

A professional framework for building enterprise-grade software with AI-assisted development, strict engineering discipline, and human oversight at every critical layer.

**This is not a collection of prompts.** It is a complete engineering execution system.

## Start Here

**[docs/START-HERE.md](docs/START-HERE.md)** - choose your path first.

| I am building... | Go here |
|------------------|---------|
| Frontend only | [docs/paths/frontend-only.md](docs/paths/frontend-only.md) |
| Backend only | [docs/paths/backend-only.md](docs/paths/backend-only.md) |
| Full stack | [docs/paths/full-stack.md](docs/paths/full-stack.md) |
| One task | [docs/paths/single-task.md](docs/paths/single-task.md) |

Wire the OS to your project: [docs/adopt-in-your-project.md](docs/adopt-in-your-project.md)

**MCP (auto-resolve prompts by track):** [docs/mcp-setup.md](docs/mcp-setup.md)

## What You Get

| Layer | Path | Purpose |
|-------|------|---------|
| Developer journey | [docs/developer-journey/](docs/developer-journey/) | Onboarding → daily practices → feature delivery → ship |
| Agents | [agents/](agents/) | 7 role-specific agent packages with enterprise prompts |
| Workflows | [workflows/](workflows/) | 8-stage delivery playbooks + cross-cutting reviews |
| Prompts | [prompts/](prompts/) | Global prompts + [enterprise prompt contract](prompts/PROMPT-CONTRACT.md) |
| Standards | [standards/](standards/) | API, security, testing, observability, git |
| Starter kits | [starter-kits/](starter-kits/) | 6 production-ready project templates |
| Architecture | [architecture/](architecture/) | ADRs and system patterns |

## Philosophy

**AI accelerates execution. Humans own the architecture.**

Every agent has hard constraints. Every workflow has a human checkpoint. Nothing ships without deliberate review.

## Quick Links

- [Feature delivery (8 stages)](docs/developer-journey/03-feature-delivery.md)
- [Coding with AI-OS](docs/developer-journey/05-coding-with-ai-os.md)
- [Decision tree](docs/developer-journey/06-decision-tree.md)
- [Security review prompt](workflows/prompts/stage-05-security-review.md)
- [Contributing](CONTRIBUTING.md)
- Roadmap: local planning file (`docs/ROADMAP.md`, not in repo)

## Validate Prompts

```powershell
.\scripts\validate-prompt-contract.ps1
```

## Vision Document

Full narrative and positioning: [ai-engineering-os.md](ai-engineering-os.md)

---

*AI-Augmented Engineering Operating System - Enterprise Edition*
