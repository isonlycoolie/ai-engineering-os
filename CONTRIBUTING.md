# Contributing

Thank you for improving AI Engineering OS.

## What to contribute

Phase 1 focuses on **engineering guidance only**:

- Prompts that consistently improve AI outputs
- Standards and checklists grounded in production practice
- Workflows that stay concise and stack-agnostic

## What not to contribute (Phase 1)

- MCP servers, install scripts, or runtime tooling
- Project templates or starter kits
- Mandated folder structures or stack-specific requirements in core package files
- Automation frameworks or orchestration layers

## Package rules

Each package under `*-ai-os/` must contain exactly these seven files:

- `README.md`
- `instructions.md`
- `standards.md`
- `workflows.md`
- `prompts.md`
- `checklist.md`
- `references.md`

Keep packages **self-contained**. Stack-specific examples belong in `references.md` only.

## Style

- Passive guidance ("when implementing UI...") not agent runtime language
- No em-dashes (Unicode U+2014) in markdown
- Small, focused pull requests
- One concept per commit when possible

## Pull request checklist

- [ ] Changes are limited to package markdown or root docs
- [ ] No install/MCP/template additions
- [ ] Package still has exactly 7 files
- [ ] Content is stack-agnostic in `instructions.md` and `standards.md`

## Legacy structure

Pre-Phase-1 content (agents, starter kits, registry, MCP) lives on tag `v1-legacy`. Do not restore that structure on `main` without an explicit project decision.
