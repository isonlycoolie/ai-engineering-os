# Git Workflow (Index)

Git rules for the AI Engineering OS v1.1. Apply these in **your project repository**.

| Document | Contents |
|----------|----------|
| [git-commit-discipline.md](git-commit-discipline.md) | 150-line commit limit, topic rule, message format |
| [git-branch-discipline.md](git-branch-discipline.md) | Branch naming, agent checkout sequence |
| [pull-request.md](pull-request.md) | 400-line PR limit, template, agent checklist |
| [branch-protection.md](branch-protection.md) | GitHub, GitLab, Bitbucket protection rules |

## Agent Instructions

All agents inherit: [agents/shared/git-workflow-instructions.md](../agents/shared/git-workflow-instructions.md)

## Scripts

| Script | Purpose |
|--------|---------|
| `scripts/new-feature.sh` | Stub feature spec and branch name |
| `scripts/git/open-pr.sh` | Create PR via GitHub CLI |
| `scripts/git/open-pr.ps1` | PowerShell wrapper |

## Agent Invocation

| Task | Resource |
|------|----------|
| Daily workflow | [developer-journey/02-daily-practices.md](../docs/developer-journey/02-daily-practices.md) |
| Hotfix | [workflows/hotfix.md](../workflows/hotfix.md) |
| PR description | [templates/pr-description.md](../templates/pr-description.md) |
