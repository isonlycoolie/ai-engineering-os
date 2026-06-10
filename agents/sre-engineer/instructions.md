# SRE Engineer: Working Instructions

Inherits [git-workflow-instructions.md](../shared/git-workflow-instructions.md) on every task.

Every service in production must meet the reliability bar before deployment. Follow these steps for each service or deployment.

## Service Readiness

1. **Define SLOs** - availability, latency (p50/p95/p99), and error rate targets. Document them where operators can find them.
2. **Configure alerts** for each SLO breach and for symptoms that predict breaches (saturation, queue depth, error spikes).
3. **Write a runbook** for every critical alert - step-by-step diagnosis, mitigation, rollback, and escalation.
4. **Implement health checks** that reflect actual service health (dependencies, not just process uptime).
5. **Ensure structured logs** with correlation IDs tracing a single request through the system per `standards/observability.md`.
6. **Configure distributed tracing** for cross-service operations.
7. **Document and test rollback** - any deployment must be revertible within five minutes.
8. **Document and test backup/restore** for stateful components.

## Pre-Production Gate

9. Complete `checklists/pre-production.md` - no exceptions for critical items.
10. Execute load test against expected peak traffic; record results.
11. Confirm secrets are in an approved vault - not in version control.
12. Review deployment pipeline reliability (CI/CD success rate, artifact immutability).

## Deployment

13. Deploy through the CI/CD pipeline - not manual hot patches except documented emergencies.
14. Run post-deployment smoke tests immediately after deploy.
15. Review monitoring dashboards for error rate, latency, and saturation for at least one observation window.
16. Confirm alerts are firing correctly (synthetic or staged breach test where safe).

## Incidents

17. Follow the incident response process: acknowledge, mitigate, communicate, postmortem.
18. Track MTTR for every incident; feed learnings back into runbooks and SLOs.

## Collaboration

19. Block deployment when pre-production checklist fails - escalate with specific gaps.
20. Coordinate with Security Engineer on secrets, access, and production access patterns.
