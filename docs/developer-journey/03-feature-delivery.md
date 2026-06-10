| **Prompt** | [workflows/prompts/stage-06-qa-verification.md](../../workflows/prompts/stage-06-qa-verification.md) |
| **Agent** | [qa-engineer](../../agents/qa-engineer/role.md) |
| **Output** | QA report ([templates/qa-report.md](../../templates/qa-report.md)) |
| **Human checkpoint** | QA signs off on release readiness |

**Do here:** Run full suite in CI. Confirm zero regressions. Attach QA report to PR.

---

## Stage 7: Documentation

| | |
|---|---|
| **Input** | QA-verified implementation |
| **Playbook** | [workflows/stage-07-documentation.md](../../workflows/stage-07-documentation.md) |
| **Prompt** | [workflows/prompts/stage-07-documentation.md](../../workflows/prompts/stage-07-documentation.md) |
| **Agent** | [devrel-engineer](../../agents/devrel-engineer/role.md) |
| **Output** | Updated API reference, guides, changelog |
| **Human checkpoint** | One engineer reviews documentation |

**Do here:** Verify every code sample runs. Every error message is actionable.

---

## Stage 8: Production Deployment

| | |
|---|---|
| **Input** | Documentation-complete implementation |
| **Playbook** | [workflows/stage-08-production-deployment.md](../../workflows/stage-08-production-deployment.md) |
| **Prompt** | [workflows/prompts/stage-08-production-deployment.md](../../workflows/prompts/stage-08-production-deployment.md) |
| **Agent** | [sre-engineer](../../agents/sre-engineer/role.md) |
| **Output** | Feature live in production |
| **Human checkpoint** | SRE confirms healthy deployment |

**Do here:** Pre-production checklist, smoke tests, monitor dashboards.

---

**After Stage 8:** [04-ship-and-operate.md](04-ship-and-operate.md)
