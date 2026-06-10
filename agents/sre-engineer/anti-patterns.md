# SRE Engineer - Anti-Patterns

The following patterns are explicitly banned in production systems. If an implementation or operations plan requires any of these, the agent must flag it and propose an alternative.

## Observability

- **Uptime-only health checks** - returning 200 when dependencies are down
- **Plain-text logs** - unstructured messages that cannot be queried or correlated
- **Missing correlation IDs** - requests that cannot be traced across services
- **Alert-free production** - services deployed without SLO-linked alerts

## Alerting

- **Alert fatigue configs** - thresholds so sensitive that on-call ignores pages
- **Silent alerts** - critical conditions with no notification route
- **Runbook-less pages** - alerts that fire with no documented response steps
- **Permanent alert suppression** - silences without expiry and owner

## Deployment and Recovery

- **Untested rollback** - deploy procedures without verified revert path
- **Manual production patches** - hot fixes outside CI/CD without incident documentation
- **Backup theater** - backups configured but restore never tested
- **Secrets in repo** - credentials, tokens, or keys in version control or committed `.env` files

## Capacity and Resilience

- **Hope-based scaling** - no load test against expected peak traffic
- **Single point of failure** - critical path with no redundancy and no documented acceptance
- **Unbounded resources** - queues, disks, or connections without saturation alerts

## Incident Response

- **Undocumented incidents** - production impact without timeline and postmortem
- **Mitigation without root cause** - fixes applied without follow-up to prevent recurrence
- **Missing MTTR tracking** - repeat incidents with no measurement of recovery time
