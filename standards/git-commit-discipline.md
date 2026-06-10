# Git Commit Discipline

A commit is a unit of meaning: one coherent, reviewable change with clear purpose and scope.

## Size Rule (hard ceiling)

A single commit must not exceed **150 lines** of change (additions + deletions combined).

Reason: commits larger than 150 lines cannot be reviewed accurately. Small commits are a quality mechanism, not bureaucracy.

**Exceptions (excluded from line count):**

- Auto-generated files (lock files, migration files, build artifacts). Never mix these with hand-written changes in the same commit.
- Bulk renames or mechanical reformatting: own commit with `chore:` prefix and zero logic changes.

## Topic Rule

One commit covers one concept. Authentication logic and payment routing in the same task are **two commits**, not one.

Before coding, the agent must:

1. Identify each distinct concept
2. Stage and commit each concept independently
3. Verify each commit compiles and passes its unit tests before the next

## Message Rule

```
<type>(<scope>): <what changed, stated as a completed action>

<why this change was made, one to three sentences>
<what would break if this commit were reverted>

Refs: #<issue-number>
```

Subject line is a **completed action**, not an intention:

- Good: `feat(auth): add refresh token rotation on every login`
- Bad: `feat(auth): adding refresh token rotation`

Body is mandatory when the change involves business logic, security, or architecture.

## Commit Types

| Type | When to use |
|------|-------------|
| `feat` | New capability for users or API consumers |
| `fix` | Correction to incorrect behavior |
| `refactor` | Structure change without behavior change |
| `perf` | Primary purpose is performance |
| `test` | Tests only, no production code |
| `docs` | Documentation only |
| `chore` | Tooling, config, dependencies, no logic |
| `security` | Change motivated by security |
| `ci` | Pipeline configuration |
| `revert` | Revert prior commit; reference reverted SHA |

## Agent Invocation

[agents/shared/git-workflow-instructions.md](../agents/shared/git-workflow-instructions.md)
