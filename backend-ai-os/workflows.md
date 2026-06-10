# Workflows

## Stage alignment

| Stage | Backend responsibility |
|-------|------------------------|
| 1. Requirement clarity | Acceptance criteria, API contract, auth rules, data model impact |
| 2. Architecture review | Layering, migrations, indexes, blast radius, rollback |
| 3. Test specification | Contract tests, failure modes, authz cases |
| 4. Implementation | Boundary → service → persistence; tests with failure modes |
| 5. Security review | Authz, injection, secrets, dependency scan |
| 6. QA verification | Integration tests, regression suite |
| 7. Documentation | OpenAPI, changelog, error codes |
| 8. Production deploy | Monitor errors, latency, saturation |

## Implementation loop

Clarify → Plan (files, migrations, indexes) → Implement → Security pass → Checklist → Human PR → Ship
