# Stage 5 - Security Review

Security sign-off on completed implementation before QA verification.

## Position in Flow

| | |
|---|---|
| **Previous** | [Stage 4 - Implementation](stage-04-implementation.md) |
| **Next** | [Stage 6 - QA Verification](stage-06-qa-verification.md) |
| **Prompt** | [workflows/prompts/stage-05-security-review.md](prompts/stage-05-security-review.md) |
| **Agent** | [security-engineer](../agents/security-engineer/role.md) |

---

## Input

- Pull request with completed implementation on `feature/*` branch
- Linked feature spec, test spec, and ADR (if structural)
- CI green on the PR branch
- Pre-delivery checklists complete from implementing agents

---

## Output

- Security sign-off: **approved** | **changes required** | **blocked**
- Inline PR comments for every medium+ finding with attack-path evidence
- Completed [security-review checklist](../agents/security-engineer/checklists/security-review.md)
- Slack summary posted to the team security channel
- Updated threat model when significant new entry points were introduced

---

## Process

### 1. Triage the change

1. Read the PR description, linked spec, and full diff.
2. List all new or modified entry points (routes, webhooks, jobs, UI surfaces, CLI commands).
3. Identify whether a threat model update is required (new trust boundaries, auth flows, or data stores).

### 2. Run the security review

1. Invoke the Security Engineer agent with [stage-05-security-review prompt](prompts/stage-05-security-review.md).
2. Review **diff-only** - read unchanged code only when required to prove exploitability.
3. For each entry point, trace **attacker-controlled input** to **sinks** (database, shell, filesystem, outbound HTTP, authorization decision, logs, HTML response).
4. Verify controls: schema validation, output encoding, service-layer auth, rate limits, secrets handling, CORS, security headers.
5. Run dependency audit on new or changed dependencies ([dependency-audit prompt](prompts/dependency-audit.md) when dependencies changed).

### 3. Record findings

1. Post **inline PR comments** on exact diff lines - one finding per comment.
2. Tag severity: `[critical]`, `[high]`, or `[medium]`.
3. Include attack path, evidence (file:line), and remediation - not vague hardening advice.
4. Do **not** open fix PRs from this workflow - report only.

### 4. Complete checklist and sign-off

1. Complete [security-review checklist](../agents/security-engineer/checklists/security-review.md).
2. Post **Slack summary**: PR link, sign-off status, finding count by severity, blockers.
3. Human security engineer reviews and approves or escalates.

---

## Human Checkpoint

| Role | Decision |
|------|----------|
| Security Engineer (human) | Approves sign-off, requests changes, or escalates critical/high items |

**Hard stops:**

- Zero unaddressed **critical** or **high** findings before Stage 6
- Medium+ findings without attack-path evidence are invalid - do not publish
- Auth, data-handling, or dependency changes on hotfix path still require this review

---

## Exit Criteria

- [ ] PR diff reviewed with attacker-input-to-sink tracing
- [ ] Dependency audit complete for new or changed packages
- [ ] `checklists/security-review.md` complete
- [ ] Inline PR comments posted for all medium+ findings
- [ ] Slack summary delivered
- [ ] Human security engineer sign-off recorded on PR

---

## Escalation

| Situation | Action |
|-----------|--------|
| Architectural security gap | Escalate to Architecture Engineer with ADR recommendation |
| Critical/high finding unresolved | Block Stage 6; human security engineer owns remediation |
| Ambiguous trust boundary | Stop review; resolve requirement before sign-off |

---

