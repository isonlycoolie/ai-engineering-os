# Prompt Invocations - Before and After

> Shows how applying the [PROMPT-CONTRACT](../prompts/PROMPT-CONTRACT.md) and attaching OS context changes agent output quality.

---

## Scenario

Engineer asks an agent to implement "user data export" on a Node.js API without providing structure.

---

## Before (vague prompt)

```text
Add a user data export feature to our API. Users should be able to download their data.
Make it secure and add tests.
```

### Typical failure modes

| Problem | What happens |
|---------|----------------|
| No scope boundary | Agent invents admin bulk-export endpoints |
| No evidence bar | "Looks secure" with no threat model or authz tests |
| No workflow | Jumps to code without reading existing auth middleware |
| No hard stops | Agent may suggest merge/deploy commands |
| Untestable goal | "Secure" never defined - reviewer cannot sign off |

### Sample output fragment (problematic)

```text
I've added GET /export?userId=123 that returns all user data as JSON.
You can deploy with docker-compose up.
```

---

## After (contract-compliant invocation)

**Attach:**

1. [prompts/global-system-prompt.md](../../prompts/global-system-prompt.md)
2. [agents/backend-engineer/prompts/primary.md](../../agents/backend-engineer/prompts/primary.md)
3. [examples/feature-spec-user-export.md](../feature-spec-user-export.md)
4. Relevant code: `src/routes/`, `src/middleware/auth.ts`, `standards/api.md`

**Prompt body:**

```text
Implement Stage 4 for FEAT-042 per the attached feature spec and test spec.
Work on branch feature/user-data-export. Do not push or open a PR.
```

### Why this works

| Contract section | Effect |
|------------------|--------|
| **Goal** | Deliverable = implementation + tests + pre-delivery checklist |
| **Scope** | Own-user export only; no admin paths |
| **Workflow** | Read spec → read code → list files → implement → checklist |
| **What to look for** | Auth at route, validation at boundary, no secrets in logs |
| **Evidence bar** | Tests for happy path + 2 failure modes per endpoint |
| **Response rules** | Plan first, summary + handoff last, no deploy |
| **Constraints** | No architecture changes without ADR |

### Sample output fragment (expected)

```text
## Plan
Files: src/routes/exports.ts (new), src/services/export-job.ts (new), ...
Approach: async job + 202 Accepted per REQ-001. Auth via existing session middleware.

## Ambiguities
None - AMB-001 resolved in feature spec (payment metadata scope).

## Implementation
[code changes]

## Test evidence
- TC-001 POST happy path: pass
- TC-002 duplicate request 409: pass
- Unauthorized GET: pass

## Checklist
Pre-delivery: 11/11 complete

## Handoff
Recommend: Security Engineer Stage 5 review - new PII export surface.
```

---

## Validation

After authoring or changing prompts, run:

```bash
# Bash (Git Bash / Linux / macOS)
./scripts/validate-prompt-contract.sh

# PowerShell
./scripts/validate-prompt-contract.ps1
```

---

## Related

- [prompts/PROMPT-CONTRACT.md](../../prompts/PROMPT-CONTRACT.md)
- [ai-collaboration/context-packing-guide.md](../../ai-collaboration/context-packing-guide.md)
- [docs/developer-journey/05-coding-with-ai-os.md](../../docs/developer-journey/05-coding-with-ai-os.md)
