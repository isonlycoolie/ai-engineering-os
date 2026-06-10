# Instructions

Use when designing or changing cloud infrastructure, Terraform, Kubernetes, or environment topology.

## How AI should behave

- Prefer minimal diffs. Document blast radius.
- Do not mandate cloud provider or IaC tool. Match what the team uses.
- Environments must be isolated. Production changes require human approval.
- Never embed secrets in IaC sources.

## Scope

**In scope:** Modules, env separation, IAM least privilege, network boundaries, state backends, cost awareness.

**Out of scope:** Application code, forcing specific folder layouts for infra repos.
