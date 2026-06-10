# Runbook: [Alert Name]

> **Service:** [service name]
> **Severity:** Critical | High | Medium
> **SLO impact:** [availability / latency / error rate]
> **Last tested:** YYYY-MM-DD
> **Owner:** [team / on-call rotation]

## Alert description

**What fires:** [Alert condition in plain language]

**Monitor query:** `[query or link]`

**Typical causes:**

1. [Cause]
2. [Cause]

## Immediate actions (first 5 minutes)

1. [ ] Acknowledge alert in [pager/incident tool]
2. [ ] Check [dashboard link] for error rate, latency, saturation
3. [ ] Determine user impact: [how to assess]
4. [ ] If user-facing SLO breached → page [escalation contact]

## Diagnosis

### Step 1: [Check logs]

```bash
# Example query or command
```

**Look for:** [patterns, error codes, correlation IDs]

### Step 2: [Check dependencies]

| Dependency | Health check | Dashboard |
|------------|--------------|-----------|
| [DB/API/queue] | [endpoint/command] | [link] |

### Step 3: [Correlate traces]

- Trace ID from logs: `requestId` / `trace_id`
- Dashboard: [APM link]

## Mitigation

| Scenario | Action | Expected result |
|----------|--------|-----------------|
| [Bad deploy] | Roll back - see Rollback below | Error rate returns to baseline |
| [Dependency down] | [Failover / circuit breaker / scale] | Partial or full recovery |
| [Saturation] | [Scale up / throttle / drain queue] | Latency stabilizes |

## Rollback procedure

**Target time:** ≤ 5 minutes

1. [ ] `[exact command or pipeline step]`
2. [ ] Verify deployment revision: `[how]`
3. [ ] Run smoke test: `[test name or script]`
4. [ ] Confirm alert clears within [N] minutes

## Escalation

| Condition | Escalate to | Contact |
|-----------|-------------|---------|
| Rollback fails | [team] | [channel/phone] |
| Data integrity suspected | [team] | [channel] |
| SLO breach > [N] minutes | [incident commander] | [channel] |

## Post-incident

- [ ] Update incident timeline
- [ ] Record MTTR
- [ ] File postmortem if SLO breached or customer impact
- [ ] Update this runbook if steps were wrong or missing

## Related links

- SLO definition: [link]
- Architecture / ADR: [link]
- Incident report template: [templates/incident-report.md](incident-report.md)

---

*Generated from AI Engineering OS - Runbook template v1.0*
