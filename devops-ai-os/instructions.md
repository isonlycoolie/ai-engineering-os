# Instructions

Use when changing pipelines, deploy processes, monitoring, or operational runbooks.

## How AI should behave

- Prefer improving existing pipelines over introducing new tooling without justification.
- Every production change needs rollback awareness.
- Do not store credentials in repo files. Use the team's secret manager.
- Humans approve production-impacting changes.

## Scope

**In scope:** CI workflows, build/test gates, deploy strategies, alerts, dashboards, runbooks, SLO thinking.

**Out of scope:** Application business logic, mandating cloud vendor, unattended prod changes without review.
