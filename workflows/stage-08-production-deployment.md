# Stage 8 - Production Deployment

Deploy documentation-complete, QA-verified implementation to production.

## Position in Flow

| | |
|---|---|
| **Previous** | [Stage 7 - Documentation](stage-07-documentation.md) |
| **Next** | [04 - Ship and Operate](../docs/developer-journey/04-ship-and-operate.md) |
| **Prompt** | [workflows/prompts/stage-08-production-deployment.md](prompts/stage-08-production-deployment.md) |
| **Agent** | [sre-engineer](../agents/sre-engineer/role.md) |

---

## Input

- Documentation-complete implementation ready for production
- Security sign-off, QA report, and updated runbooks (if applicable)
- CI/CD pipeline configured for the service
- Monitoring dashboards and alert routing in place

---

## Output

- Feature live in production via CI/CD pipeline
- Completed [pre-production checklist](../agents/sre-engineer/checklists/pre-production.md)
- Post-deploy verification within 30 minutes (smoke tests, dashboards, SLO check)
- Deploy readiness decision: **go** | **no-go** | **conditional**

---

## Process

### 1. Pre-deploy verification

1. Invoke the SRE Engineer agent with [stage-08-production-deployment prompt](prompts/stage-08-production-deployment.md).
2. Verify SLOs, alerts, runbooks, and observability per `standards/observability.md`.
3. Confirm health checks reflect dependency health - not just process uptime.
4. Validate rollback procedure (target: revert within five minutes).
5. Complete [pre-production checklist](../agents/sre-engineer/checklists/pre-production.md).
6. Record load test results for new services or major capacity changes.

### 2. Deploy

1. Execute deployment through CI/CD - no manual production changes without incident justification.
2. Human SRE engineer confirms go/no-go before pipeline promotion.
3. Monitor deployment progress; halt on error-rate or latency anomalies.

### 3. Post-deploy verification (within 30 minutes)

1. Run smoke tests against production.
2. Confirm error rate and latency within SLO.
3. Review dashboards for expected traffic patterns.
4. Confirm no new critical alerts.
5. Verify rollback procedure remains ready.

### 4. Hand off to operations

1. Record deploy timestamp, revision, and verification results.
2. Update on-call runbooks if new alerts were introduced.
3. Notify stakeholders of successful deployment.

---

## Human Checkpoint

| Role | Decision |
|------|----------|
| SRE Engineer (human) | Confirms healthy deployment and production readiness |

**Hard stops:**

- Unchecked critical items on pre-production checklist block deploy
- No deploy without tested rollback within five minutes
- Secrets must be in an approved vault - not in version control

---

## Exit Criteria

- [ ] Pre-production checklist complete (or exceptions documented with owners)
- [ ] Deployment executed via CI/CD
- [ ] Smoke tests pass in production
- [ ] Error rate and latency within SLO
- [ ] Dashboards reviewed - no unexpected anomalies
- [ ] Human SRE confirms healthy deployment

---

## Rollback

If post-deploy verification fails:

1. Execute documented rollback procedure immediately.
2. Notify on-call and stakeholders.
3. Open incident if user impact occurred - see [incident-response.md](incident-response.md).
4. Do not re-attempt deploy until root cause is identified.

---

## Related

- [04 - Ship and Operate](../docs/developer-journey/04-ship-and-operate.md)
- [templates/runbook.md](../agents/sre-engineer/templates/runbook.md)
- [standards/observability.md](../standards/observability.md)
- [03 - Feature Delivery](../docs/developer-journey/03-feature-delivery.md)
