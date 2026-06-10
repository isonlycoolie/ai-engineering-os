# Hotfix Workflow

Emergency path for production defects that cannot wait for the normal eight-stage flow.

## When to Use

Use a hotfix when:

- Production is impaired or at imminent risk of impairment
- User-facing functionality is broken for a significant user segment
- A security vulnerability is actively exploitable in production

Do **not** use a hotfix for feature work, refactors, or non-urgent improvements - use the standard [feature delivery flow](../docs/developer-journey/03-feature-delivery.md).

---

## Branch Strategy

```
main ──► hotfix/<short-description>
```

1. Branch from `main` - not from `develop` or `feature/*`.
2. One hotfix per branch; minimal scope only.
3. Merge back to `main` first, then cherry-pick or merge to `develop`.

See [standards/git-workflow.md](../standards/git-workflow.md).

---

## Process

### 1. Declare and triage

1. Confirm severity with on-call SRE and feature owner.
2. Document the defect: symptoms, impact, affected revision, rollback option.
3. Assign incident commander if SEV-1 or SEV-2 - see [incident-response.md](incident-response.md).

### 2. Implement minimal fix

1. Invoke [hotfix-incident-response prompt](prompts/hotfix-incident-response.md) for scoped guidance.
2. Change only what is required to restore correct or safe behavior.
3. Add or update a test that reproduces the defect and proves the fix.
4. Run targeted tests locally; confirm CI green before review.

### 3. Accelerated review gates

| Gate | Requirement |
|------|-------------|
| Code review | At least one human reviewer - expedited |
| Security review | **Required** for auth, authorization, secrets, or data-handling changes - use [stage-05 prompt](prompts/stage-05-security-review.md) |
| QA | Targeted regression on affected area; full suite if blast radius is unclear |
| SRE | Confirm rollback ready; on-call aware of deploy window |

### 4. Deploy

1. Deploy through CI/CD when possible.
2. Human SRE approves production promotion.
3. Post-deploy smoke tests within 15 minutes.
4. Monitor error rate, latency, and business metrics for 30 minutes.

### 5. Retroactive follow-up (within 48 hours)

1. Merge equivalent fix to `develop` if not already synced.
2. Complete any deferred documentation updates.
3. Add regression tests missed during the emergency.
4. File postmortem ticket for SEV-1/SEV-2 - see [04 - Ship and Operate](../docs/developer-journey/04-ship-and-operate.md).

---

## Human Checkpoints

| Step | Owner |
|------|-------|
| Hotfix justification | On-call SRE + feature owner |
| Security review (when in scope) | Security engineer |
| Production deploy | SRE engineer |
| 48-hour follow-up | Original implementer |

---

## Hard Rules

- **Minimal fix only** - no drive-by refactors or unrelated changes
- **Security review still required** for auth, secrets, and data-path changes
- **No skipping rollback verification** before deploy
- **Document the hotfix** in changelog and incident report when user-facing

---

## Related

- [incident-response.md](incident-response.md)
- [prompts/hotfix-incident-response.md](prompts/hotfix-incident-response.md)
- [prompts/debugging-prompt.md](../prompts/debugging-prompt.md)
- [04 - Ship and Operate](../docs/developer-journey/04-ship-and-operate.md)
