# Security Review - Sample Output

> **Sample Stage 5 output** for PR `feature/user-data-export`. Illustrates evidence bar from [agents/security-engineer/prompts/primary.md](../agents/security-engineer/prompts/primary.md).

| Field | Value |
|-------|-------|
| **PR / branch** | #284 / `feature/user-data-export` |
| **Reviewer** | Security Engineer (agent) |
| **Date** | 2026-06-10 |
| **Recommendation** | **Changes required** before human security sign-off |

---

## Executive Summary

Two medium-severity findings require remediation: IDOR risk on export status endpoint and predictable S3 object keys. One low informational item on rate limiting. No critical or high findings with evidence.

---

## Findings

### SEC-001 - IDOR on export status (Medium)

| Field | Detail |
|-------|--------|
| **Severity** | Medium |
| **File** | `src/routes/exports.ts:47` |
| **CWE** | CWE-639 (Authorization Bypass Through User-Controlled Key) |

**Attack path:**

1. Attacker authenticates as User A.
2. Attacker learns or guesses User B's `requestId` (UUID v4 - low brute force, but leaked via support logs in sample env).
3. `GET /v1/users/me/data-export/{requestId}` resolves job by `requestId` only - does not verify `job.userId === session.userId`.
4. Attacker reads User B's export status and metadata (filename, completion time).

**Impact:** Information disclosure of export metadata; enables targeted follow-up if download token generation is also flawed.

**Remediation:** Enforce `WHERE request_id = $1 AND user_id = $2` in repository layer; return `404` for cross-user access (not `403`) to avoid enumeration.

**Status:** Open

---

### SEC-002 - Predictable export object path (Medium)

| Field | Detail |
|-------|--------|
| **Severity** | Medium |
| **File** | `src/services/export-storage.ts:22` |
| **CWE** | CWE-330 (Use of Insufficiently Random Values) |

**Attack path:**

1. Export files stored at `exports/{userId}/{requestId}.json` in shared bucket.
2. Bucket policy misconfiguration (not in diff) would expose path-guessing if `userId` is sequential integer.
3. Attacker with bucket read on prefix enumerates other users' exports.

**Impact:** Confidentiality breach of full export payload under misconfigured IAM.

**Remediation:** Use opaque storage key `exports/{randomUuid}.json`; map to `requestId` in database only. Verify bucket is private and blocked from public ACLs in IaC review.

**Status:** Open

---

### SEC-003 - Missing rate limit on export enqueue (Low / Informational)

| Field | Detail |
|-------|--------|
| **Severity** | Low |
| **File** | `src/routes/exports.ts:12` |

**Note:** `POST /v1/users/me/data-export` has no per-user rate limit. Abuse could queue expensive jobs. Recommend alignment with global API rate limits per [standards/security.md](../standards/security.md).

**Status:** Recommendation

---

## Checklist Summary

| Area | Result | Notes |
|------|--------|-------|
| Authentication | Pass | Session required on all new routes |
| Authorization | **Fail** | SEC-001 |
| Input validation | Pass | Zod schema on POST body |
| Secrets in code | Pass | S3 credentials from env |
| Dependency audit | Pass | No new critical/high CVEs |

---

## Sign-Off Recommendation

**Rework required** - remediate SEC-001 and SEC-002, re-run security review on updated diff.

| Role | Decision |
|------|----------|
| Security Engineer (agent) | Changes required |
| Human security engineer | _Pending after fixes_ |

