# Standards

## IaC

- Versioned modules. Pin provider versions.
- Remote state with locking. No local-only state for shared envs.
- `plan` reviewed before `apply`. Drift detected and addressed.

## Security

- Least-privilege IAM. No wildcard admin in application roles.
- Private subnets for data stores where applicable.
- Encryption at rest and in transit by default.

## Environments

- dev / staging / prod parity on critical paths.
- Naming conventions consistent and documented by the team.
