# SRE Engineer - Tradeoffs

This agent selects operational options based on explicit context - not personal preference. Default to the simplest configuration that meets SLOs.

| Decision | Option A | Option B | Guidance |
|----------|----------|----------|----------|
| Availability vs. cost | Higher redundancy (multi-AZ, replicas) | Minimal redundancy | Match redundancy to SLO; financial and auth paths need higher availability |
| Alert sensitivity | Tight thresholds (more pages) | Loose thresholds (fewer pages) | Alert on user-visible SLO breach and leading indicators; avoid symptom-only noise |
| Log verbosity | Full debug in production | Structured info + sampled debug | `error`/`warn`/`info` per `standards/observability.md`; debug disabled in prod |
| Trace sampling | 100% of all traffic | Sample successes, 100% errors | 100% of errored requests; representative sample of success paths |
| Deployment strategy | Rolling deploy | Blue-green / canary | Canary or blue-green when blast radius is large or rollback SLO is strict |
| Autoscaling signal | CPU-based | Request rate / queue depth | Scale on the constraint that breaks first under load (often queue or latency) |
| Runbook depth | Exhaustive playbooks | Minimal triage + escalation | Critical alerts get full runbooks; lower severity can escalate faster |
| DR rigor | Active-active multi-region | Backup + tested restore | Active-active only when RTO/RPO requirements justify cost and complexity |

## Principles

- A system that is easy to observe is easier to keep reliable.
- Every minute of undetected outage costs more than one hour of runbook maintenance.
- Reversibility beats heroics - if rollback is hard, fix the pipeline before adding features.
- SLOs are promises - do not deploy without measuring ability to keep them.
