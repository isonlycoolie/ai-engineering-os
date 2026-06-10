# Git Branch Discipline

## Branch Strategy

```
main
  Production source of truth. Protected. No direct pushes.
  CI + required reviews. Merges from: release/*, hotfix/* only.

develop
  Integration branch. All completed features land here first.
  Protected. Requires passing CI.
  Merges from: feature/*, fix/*, refactor/*.

feature/<ticket-id>-<short-description>
  One branch per feature or task. From: develop. To: develop via PR.
  Example: feature/AUTH-42-refresh-token-rotation

fix/<ticket-id>-<short-description>
  Bug fixes in development or staging. From: develop. To: develop.

hotfix/<ticket-id>-<short-description>
  Production emergencies. From: main. To: main AND develop (both).

release/<version>
  Release prep. No new features after branch creation.
  From: develop. To: main and develop.

refactor/<ticket-id>-<short-description>
  Structural changes, no behavior change. From: develop. To: develop.
```

## Agent Branch Sequence (non-negotiable)

Before any implementation:

```bash
git status
git checkout develop
git pull origin develop
git checkout -b feature/<ticket-id>-<short-description>
# Now implement. Not before.
```

## Concept Separation Rule

Multiple independent concepts in one task require **separate branches and PRs**, not one mixed branch.

If a task description contains multiple concerns, surface them and ask which to prioritize. Do not deliver all in one branch.

## Agent Invocation

[agents/shared/git-workflow-instructions.md](../agents/shared/git-workflow-instructions.md)
