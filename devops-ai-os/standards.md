# Standards

## CI/CD

- Fast feedback: lint, test, and security scan on PRs.
- Build artifacts immutable and traceable to commit SHA.
- Separate staging and production promotion with explicit gates.

## Deploy

- Rollback path documented before deploy.
- Database migrations coordinated with app deploy order.
- Feature flags for risky rollouts when the team uses them.

## Observability

- Logs structured; metrics for golden signals (latency, traffic, errors, saturation).
- Alerts actionable. Runbooks linked from alert descriptions.

## Incidents

- Blameless postmortems. Action items tracked to completion.
