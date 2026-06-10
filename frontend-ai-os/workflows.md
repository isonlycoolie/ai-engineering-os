# Workflows

## Stage alignment (feature delivery)

| Stage | Frontend responsibility |
|-------|-------------------------|
| 1. Requirement clarity | Confirm UI acceptance criteria, design references, API contract |
| 2. Architecture review | Confirm feature module placement; flag cross-feature impact |
| 3. Test specification | Align on E2E paths and a11y acceptance |
| 4. Implementation | Hooks/services first if that is the project pattern, then UI |
| 5. Security review | XSS, token handling, sensitive data in client |
| 6. QA verification | Visual, keyboard, responsive, error states |
| 7. Documentation | Update UI copy, component usage notes if applicable |
| 8. Production deploy | Smoke critical flows; watch client error dashboards |

## Daily loop

1. **Clarify** — spec, design, contract
2. **Plan** — reuse inventory, file list, a11y/perf risks
3. **Implement** — tests alongside code
4. **Review** — checklist.md complete; human review
5. **Ship** — human merges; monitor client errors post-release
