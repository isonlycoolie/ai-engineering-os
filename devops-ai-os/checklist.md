# Checklist

# SRE - Pre-Production Checklist

Complete before approving production deployment. Critical items block deploy.

## SLOs and Alerting

- [ ] SLOs are defined and documented (availability, latency, error rate)
- [ ] Alerts are configured and routed to the correct team
- [ ] Runbooks exist for every critical alert
- [ ] Alert thresholds were tested or validated against baseline traffic

## Health and Observability

- [ ] Health check endpoint returns meaningful status (dependencies, not just process uptime)
- [ ] Logging captures request ID, user context, and response time
- [ ] Logs are structured JSON per `standards/observability.md`
- [ ] Distributed tracing is configured
- [ ] Metrics cover request rate, error rate, and latency per endpoint
- [ ] Database query duration tracked at p95 with alerts where appropriate

## Recovery and Resilience

- [ ] Rollback procedure is documented and tested (target: revert within five minutes)
- [ ] Database backup and restore procedure is documented and tested
- [ ] Load test executed against expected peak traffic - results recorded
- [ ] Secrets are managed through a vault - not environment files in version control

## Deployment

- [ ] Deployment runs through CI/CD pipeline
- [ ] Post-deployment smoke tests defined and ready
- [ ] Monitoring dashboards exist for the service
- [ ] On-call rotation and escalation path documented

## Sign-off

- [ ] All critical items checked
- [ ] Exceptions documented with owner, risk acceptance, and remediation date
- [ ] Human SRE engineer confirms healthy deployment after deploy
