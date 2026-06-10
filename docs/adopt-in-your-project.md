# Adopt in Your Project

The AI Engineering OS is a rulebook and prompt library. **Your product code lives in your project repository.** Agents always work on the project you have open in the IDE, not on this OS repo.

## Three Ways to Use the OS

### 1. MCP (recommended for AI-assisted work)

Configure the [MCP server](mcp-setup.md) so agents call `aios_resolve_task_context` and receive a curated bundle for your track (frontend, backend, fullstack, single-task) without manually copying prompts.

```yaml
# ai-os.config.yaml in your project
track: frontend
os_path: .ai-os
# os_registry_url: https://your-registry.onrender.com
```

See [mcp-setup.md](mcp-setup.md).

### 2. Reference model

Keep this OS repo separate. When you work:

1. Open **your project** in the IDE (not only the OS repo).
2. Fill in [templates/project-context.md](../templates/project-context.md).
3. Attach the project context plus the role prompt (from OS repo path or submodule).
4. Attach [prompts/global-system-prompt.md](../prompts/global-system-prompt.md).

Submodule example:

```bash
cd your-project
git submodule add <os-repo-url> .ai-os-reference
```

Point `os_reference` in `ai-os.config.yaml` at `.ai-os-reference`.

### 3. Install model (optional)

Copy a minimal rule set into your project:

```powershell
.\path\to\ai-engineering-os\scripts\install-ai-os.ps1 -TargetPath C:\path\to\your-project
```

Or on Unix:

```bash
bash path/to/ai-engineering-os/scripts/install-ai-os.sh /path/to/your-project
```

This creates:

```
your-project/
├── ai-os.config.yaml
└── .ai-os/
    ├── agents/
    ├── prompts/
    ├── standards/
    ├── workflows/prompts/
    └── ai-collaboration/
```

Agents should prefer `.ai-os/standards/` when present in the project.

## Every Session Checklist

1. Paste **project context** (repo, paths, ticket, acceptance criteria).
2. Paste **global system prompt**.
3. Paste **role or workflow prompt** for the task.
4. Attach **relevant source files** from your project.
5. Complete **human review checklist** before merge.

See [ai-collaboration/context-packing-guide.md](../ai-collaboration/context-packing-guide.md).

## Choose Your Track

| You are building | Start here |
|------------------|------------|
| Frontend only | [paths/frontend-only.md](paths/frontend-only.md) |
| Backend only | [paths/backend-only.md](paths/backend-only.md) |
| Full stack | [paths/full-stack.md](paths/full-stack.md) |
| One specific task | [paths/single-task.md](paths/single-task.md) |

## New Project from Starter Kit

1. Copy a kit from [starter-kits/](../starter-kits/).
2. Run `install-ai-os` into that project (or use reference model).
3. Follow the kit's `docs/setup.md` and your track path doc.

## What Does Not Get Installed

The install script does **not** copy starter-kits, terraform, monitoring templates, or OS meta documentation. Those stay in the OS repo for reference.
