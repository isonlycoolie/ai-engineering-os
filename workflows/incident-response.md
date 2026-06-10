# Incident Response Workflow

Structured response when production breaks or degrades below SLO.

## Severity Levels

| Level | Definition | Response |
|-------|------------|----------|
| **SEV-1** | Complete outage or data loss risk | All-hands; incident commander required; status page update |
| **SEV-2** | Major degradation or partial outage | On-call + feature owner; hourly updates |
| **SEV-3** | Minor degradation, workaround exists | On-call investigates; next-business-day fix |
| **SEV-4** | Cosmetic or low-impact | Track in backlog |

---

## Roles

| Role | Responsibility |
|------|----------------|
| **Incident Commander (IC)** | Coordinates response, assigns tasks, owns communications |
| **Technical Lead** | Drives diagnosis and fix; owns rollback/deploy decisions |
| **Communications** | Stakeholder updates, status page, customer-facing messaging |
| **Scribe** | Timeline, actions taken, decisions - feeds postmortem |

---

## Process

### 1. Detect and declare (0–5 minutes)

1. Alert fires or customer report received - acknowledge on-call page.
2. Open incident channel (e.g., `#incident-YYYYMMDD-short-name`).
3. Assign IC and severity; create incident doc from [incident report template](../templates/incident-report.md).
4. If user impact is active, consider rollback before root-cause investigation.

### 2. Stabilize (5–30 minutes)

1. Invoke [hotfix-incident-response prompt](prompts/hotfix-incident-response.md) and [debugging prompt](../prompts/debugging-prompt.md).
2. Gather evidence: dashboards, logs (correlation IDs), traces, recent deploys, config changes.
3. State hypothesis before making changes - one change at a time.
4. Execute rollback if faster than fix and rollback is tested.
5. Apply hotfix per [hotfix.md](hotfix.md) if root cause is identified and fix is low-risk.

### 3. Communicate

1. **Internal:** IC posts updates every 30 minutes (SEV-1/2) - status, impact, next action, ETA.
2. **External:** Communications owner updates status page for SEV-1/2 with factual, non-speculative language.
3. Escalate if MTTR exceeds SLO or impact widens.

### 4. Resolve

1. Confirm metrics returned to baseline - not just alert cleared.
2. Run smoke tests on affected workflows.
3. Mark incident resolved; note residual risk and monitoring watch period.
4. Close incident channel after handoff to normal on-call.

### 5. Post-incident (within 5 business days for SEV-1/2)

1. Blameless postmortem with timeline, root cause, contributing factors, and action items.
2. Each action item has an owner and due date.
3. Update runbooks, alerts, and dashboards from learnings.
4. Add regression tests for the failure mode.

---

## Decision Tree

```
User impact active?
├── Yes → Rollback viable within 5 min?
│         ├── Yes → Rollback first, diagnose after stabilize
│         └── No  → Hotfix path + security review if auth/data touched
└── No  → Investigate; may defer fix to business hours (SEV-3/4)
```

---

## Evidence to Capture

- Incident start/end timestamps (UTC)
- Severity and customer impact scope
- Deploy revision at start and any changes during response
- Hypotheses tested and results
- Rollback or fix applied with verification evidence
- Dashboard screenshots or metric links

---

## Human Checkpoints

| Step | Owner |
|------|-------|
| Severity assignment | IC + on-call SRE |
| Rollback or hotfix deploy | SRE engineer |
| External communications | Communications owner |
| Postmortem | IC + engineering lead |

---

## Hard Rules
