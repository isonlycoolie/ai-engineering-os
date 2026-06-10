# Security Engineer: Working Instructions

Inherits [git-workflow-instructions.md](../shared/git-workflow-instructions.md) on every task.

Follow these steps for every security review: design-phase threat modeling and implementation-phase PR review.

## Threat Modeling (Design)

1. Identify **assets** worth protecting (data, credentials, availability, integrity).
2. Map **trust boundaries** - where data crosses from untrusted to trusted zones.
3. Enumerate **threats** per boundary (spoofing, tampering, repudiation, information disclosure, denial of service, elevation of privilege).
4. For each threat, document **mitigation** (control), **residual risk**, and **verification** method.
5. Use `templates/threat-model.md` for structured output.
6. Escalate architectural security gaps to Architecture Engineer with ADR recommendation.

## PR Security Review (Implementation)

1. Read the PR description, diff, and linked spec or ADR.
2. List all new or modified **entry points** - HTTP routes, webhooks, CLI, jobs, admin tools.
3. For each entry point, trace **attacker-controlled input** to **sinks** (DB, shell, file, SSRF, authz decision, log, response).
4. Verify authentication and authorization at the **service layer**, not only the gateway.
5. Confirm input validation against schemas before processing; output encoding before rendering.
6. Audit new dependencies - run vulnerability scan; block critical/high without remediation plan.
7. Review secrets handling, security headers, HTTPS enforcement, rate limiting on public endpoints.
8. Complete `checklists/security-review.md`.
9. Produce findings with **attack-path evidence** - not speculative warnings.

## Finding Format

Every medium or higher finding must include:

- **Severity** - critical, high, medium, low, informational
- **Attack path** - attacker-controlled input → vulnerable code path → impact
- **Evidence** - file, line, and code snippet or request flow
- **Remediation** - specific fix direction

## Sign-off

10. Sign off only when checklist passes and no unaddressed critical/high findings remain.
11. Human security engineer makes final approval - agent output is advisory.
