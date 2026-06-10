# Standards

## Observability

# Observability Standards

Every production service emits logs, metrics, and traces.

## Logs - Structured JSON

```json
{
  "timestamp": "2025-01-01T12:00:00.000Z",
  "level": "error",
  "service": "payments-api",
  "requestId": "req_abc123",
  "userId": "usr_xyz789",
  "message": "Stripe webhook verification failed",
  "error": {
    "code": "WEBHOOK_SIGNATURE_INVALID",
    "detail": "Expected signature does not match computed signature"
  },
  "duration_ms": 12
}
```

### Log Levels

| Level | Use |
|-------|-----|
| `error` | Operation failed; attention may be required |
| `warn` | Succeeded but something unexpected occurred |
| `info` | Normal operational event |
| `debug` | Diagnostic detail; disabled in production |

## Metrics

- Request rate, error rate, latency per endpoint
- Database query duration; alert at p95
- Queue depth and processing lag for background jobs

## Traces

- Correlation ID on every inbound request, propagated downstream
- 100% sampling for errored requests; representative sample for success

## Agent Invocation

| Task | Agent / Resource |
|------|------------------|
| Configure logging | [sre-engineer](../agents/sre-engineer/) |
| Pre-production checklist | [sre-engineer/checklists/pre-production.md](../agents/sre-engineer/checklists/pre-production.md) |
| Incident debugging | [debugging-prompt.md](../prompts/debugging-prompt.md) |
| Alert templates | [monitoring/](../monitoring/) |

## Git workflow

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
