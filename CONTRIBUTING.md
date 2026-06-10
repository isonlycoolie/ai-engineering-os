# Contributing to AI Engineering OS

## Principles

1. Every prompt follows the [PROMPT-CONTRACT](prompts/PROMPT-CONTRACT.md)
2. Prompts bind to the **developer's project** via project context, not to this OS repo
3. No em-dashes (Unicode U+2014) in markdown or YAML. Use colon, period, or hyphen. CI enforces via `scripts/lint-no-em-dash.sh`
4. Every workflow stage links from [03-feature-delivery.md](docs/developer-journey/03-feature-delivery.md) or a [path doc](docs/paths/)

## Adding a Prompt

1. Read [PROMPT-CONTRACT.md](prompts/PROMPT-CONTRACT.md)
2. Opening lines must reference project context and open workspace
3. Include: Goal, Scope, Workflow, What to look for, Evidence bar, Response rules, Constraints
4. Run `scripts/validate-prompt-contract.ps1` and `scripts/lint-no-em-dash.ps1`
5. Link from path doc, workflow playbook, or [06-decision-tree.md](docs/developer-journey/06-decision-tree.md)

## Adding an Agent

```powershell
.\scripts\scaffold-agent.ps1 -RoleSlug my-engineer -RoleTitle "My Engineer"
```

Agent `instructions.md` must inherit [git-workflow-instructions.md](agents/shared/git-workflow-instructions.md).

## Installing OS into a Project

```powershell
.\scripts\install-ai-os.ps1 -TargetPath C:\path\to\your-project
```

## MCP Server

Build and test locally:

```bash
python scripts/build-registry.py
cd mcp-server && npm install && npm run build
```

See [docs/mcp-setup.md](docs/mcp-setup.md). When adding assets, update [registry/manifest.yaml](registry/manifest.yaml) and track profiles under [registry/profiles/](registry/profiles/).

## Pull Requests

Use [templates/pr-description.md](templates/pr-description.md). Max 400 lines per [pull-request.md](standards/pull-request.md).

## Standards Changes

Update `standards/*.md` and agent invocation blocks. v1.1 git standards live in `standards/git-*.md`.
