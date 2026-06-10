# 04 - Ship and Operate

After Stage 8 deployment: operating the system in production.

## Post-Deploy Verification

Within 30 minutes of deploy:

- [ ] Smoke tests pass
- [ ] Error rate and latency within SLO
- [ ] Dashboards show expected traffic patterns
- [ ] No new critical alerts
- [ ] Rollback procedure confirmed ready

SRE checklist: [agents/sre-engineer/checklists/pre-production.md](../../agents/sre-engineer/checklists/pre-production.md)

## Monitoring

- Alerts: [monitoring/](../../monitoring/)
- Logs and traces: [standards/observability.md](../../standards/observability.md)
- Runbooks: [templates/runbook.md](../../templates/runbook.md)

## Incidents

When production breaks:

1. [workflows/incident-response.md](../../workflows/incident-response.md)
2. [prompts/debugging-prompt.md](../../prompts/debugging-prompt.md)
3. [workflows/prompts/hotfix-incident-response.md](../../workflows/prompts/hotfix-incident-response.md)
4. Document with [templates/incident-report.md](../../templates/incident-report.md)

## Hotfixes

Emergency path: [workflows/hotfix.md](../../workflows/hotfix.md)

- Branch from `main`
- Minimal fix only
- Security review still required for auth/data changes
- Retroactive test and doc follow-up within 48 hours

## Postmortems

For SEV-1 and SEV-2 incidents:

- Blameless postmortem within 5 business days
- Action items with owners and dates
- Update runbooks and alerts from learnings

## Continuous Improvement

- Revisit ADRs at their Review Date
- Update agent prompts when recurring review findings appear
- Run `scripts/validate-prompt-contract.sh` after prompt changes

**Back to daily work:** [02-daily-practices.md](02-daily-practices.md)
