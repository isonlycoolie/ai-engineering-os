# Git Workflow Instructions (All Agents)

Inherited by every agent. No implementation begins without this sequence.

## Before Starting Work

```
1. Confirm the task has a ticket ID. Do not begin without one.
2. git checkout develop
3. git pull origin develop
4. Identify the concept being implemented.
   If the task has multiple independent concepts, surface this to the engineer.
   Wait for priority instruction before creating any branch.
5. git checkout -b <type>/<ticket-id>-<short-description>
```

## During Implementation

```
6. Implement one concept at a time.
7. Keep each commit below 150 lines of meaningful change.
8. Stage only files for the current concept. Never use git add .
   Use git add <specific-file> or git add -p.
9. Write the commit message before committing.
   If you cannot write a clear message, the commit is too large or mixed.
10. After each commit verify:
    - Code compiles
    - Unit tests for this concept pass
    Then proceed to the next concept.
```

## Before Opening a PR

```
11. git pull origin develop --rebase
    Resolve conflicts. Rebase only; do not merge develop into feature branch.
12. Review full diff: git diff origin/develop..HEAD
    No debug logs, commented-out code, or temporary changes.
13. Complete the role pre-delivery checklist.
14. Run full test suite locally.
15. Open PR using scripts/git/open-pr.sh or project equivalent.
```

## What Agents Never Do

- Force-push to `develop` or `main`
- Commit directly to `develop` or `main`
- Merge a PR that has not passed CI
- Merge a PR without at least one human review
- Push commits with `WIP`, `temp`, `fixme`, or `test123` in the message
- Leave a branch idle more than five days without progress (close or advance)

## Standards Reference

- [git-commit-discipline.md](../../standards/git-commit-discipline.md)
- [git-branch-discipline.md](../../standards/git-branch-discipline.md)
- [pull-request.md](../../standards/pull-request.md)
