# MCP Setup

Use the AI Engineering OS MCP server so agents automatically resolve the right prompts, standards, and checklists for your track and task.

## Prerequisites

- Node.js 20+
- Cursor (or any MCP-compatible client)
- Your **project** open as the workspace (not only the OS repo)

## Quick Start (5 steps)

### 1. Configure your project

Create `ai-os.config.yaml` in your project root:

```yaml
version: "1.1"
track: frontend   # frontend | backend | fullstack | single-task
os_path: .ai-os   # optional: after install-ai-os
# os_registry_url: https://your-registry.onrender.com  # remote fallback
```

### 2. Install OS locally (recommended for offline)

```powershell
.\path\to\ai-engineering-os\scripts\install-ai-os.ps1 -TargetPath C:\path\to\your-project
```

Or use `os_registry_url` without local install.

### 3. Build the MCP server (once)

```bash
cd path/to/ai-engineering-os/mcp-server
npm install
npm run build
```

### 4. Add to Cursor MCP config

Copy [.cursor/mcp.json.example](../.cursor/mcp.json.example) to your project as `.cursor/mcp.json` or add to Cursor global MCP settings.

Set `AI_OS_ROOT` to the path of your cloned `ai-engineering-os` repo, or rely on `.ai-os/` in the project.

### 5. Use in chat

Ask the agent:

> Use `aios_resolve_task_context` with track frontend and taskType implement for ticket UI-88, then build the settings page.

The agent receives a curated bundle: global prompt, frontend engineer prompt, standards, git discipline, checklist. No backend content.

## Tools Reference

| Tool | When to use |
|------|-------------|
| `aios_resolve_task_context` | Starting any implementation, review, or debug session |
| `aios_get_track_profile` | See what a track includes and skips |
| `aios_get_asset` | Fetch one extra asset (e.g. API standard when frontend task grows) |
| `aios_get_checklist` | Before opening a PR |
| `aios_project_status` | Debug OS wiring |

## Environment Variables

| Variable | Purpose |
|----------|---------|
| `AI_OS_WORKSPACE` | Your project root (set automatically in Cursor) |
| `AI_OS_ROOT` | Path to ai-engineering-os clone or `.ai-os` parent |
| `AI_OS_REGISTRY_URL` | Remote registry if no local install |

## Remote Registry (Render)

Deploy the static registry:

1. Connect repo to Render Static Site
2. Build: `pip install pyyaml && python scripts/build-registry.py`
3. Publish: `registry/dist`
4. Set `os_registry_url` in your project's `ai-os.config.yaml`

## Troubleshooting

| Issue | Fix |
|-------|-----|
| No OS source found | Run `install-ai-os` or set `AI_OS_ROOT` / `os_registry_url` |
| Wrong track content | Check `track` in `ai-os.config.yaml` |
| Deploy assets missing | Set `capabilities.deploy: true` or use fullstack track |

See [adopt-in-your-project.md](adopt-in-your-project.md).
