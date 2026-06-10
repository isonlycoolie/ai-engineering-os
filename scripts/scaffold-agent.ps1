"@

Write-AgentFile "anti-patterns.md" @"
# $RoleTitle Agent - Anti-Patterns

Explicitly banned patterns. Flag and propose alternatives before handoff.

| Anti-pattern | Why it is banned | Alternative |
|--------------|------------------|-------------|
| | | |
"@

Write-AgentFile "tradeoffs.md" @"
# $RoleTitle Agent - Tradeoff Guidance

Select options from explicit context - not preference. Default to the simplest option that satisfies the requirement.

| Decision | Option A | Option B | Guidance |
|----------|----------|----------|----------|
| | | | |
"@

Write-AgentFile "checklists/pre-delivery.md" @"
# $RoleTitle - Pre-Delivery Checklist

Complete before handoff to human review or the next agent.

## Scope and requirements

- [ ] Task specification and acceptance criteria read in full
- [ ] All in-scope requirements addressed or explicitly flagged as out of scope

## Quality

- [ ] Output aligns with `standards/` and role instructions
- [ ] Evidence bar from `prompts/primary.md` met

## Handoff

- [ ] Open questions and risks documented
- [ ] Recommended next step named (agent role or human)

---

| Role | Name | Date | Decision |
|------|------|------|----------|
| $RoleTitle (agent) | | | Ready for review |
| Human reviewer | | | Approved / Changes required |
"@

Write-AgentFile "templates/deliverable.md" @"
# $RoleTitle Deliverable

| Field | Value |
|-------|-------|
| **Feature / task** | |
| **Author (agent run)** | $RoleSlug |
| **Date** | YYYY-MM-DD |

## Summary

## Changes

## Evidence

## Open questions

## Handoff
"@

Write-AgentFile "prompts/primary.md" (Get-PromptStub -RoleLower $RoleLower -Kind "primary" -Goal "Deliver production-ready $RoleLower output that passes the pre-delivery checklist and meets the task evidence bar.")
Write-AgentFile "prompts/review.md" (Get-PromptStub -RoleLower $RoleLower -Kind "review" -Goal "Review $RoleLower work against standards, the task spec, and the evidence bar with actionable findings.")
Write-AgentFile "prompts/handoff.md" (Get-PromptStub -RoleLower $RoleLower -Kind "handoff" -Goal "Produce a complete handoff package so the next human engineer or agent can continue without re-discovering context.")

Write-Host "Created agent: agents/$RoleSlug/"
Write-Host ""
Write-Host "Structure:"
Get-ChildItem -Path $AgentDir -Recurse -File | ForEach-Object {
    $_.FullName.Substring($RepoRoot.Length).TrimStart('\', '/')
} | Sort-Object
Write-Host ""
Write-Host "Next steps:"
Write-Host "  1. Edit role.md, instructions.md, and limitations.md"
Write-Host "  2. Customize prompts/primary.md, review.md, handoff.md"
Write-Host "  3. Run: scripts/validate-prompt-contract.ps1"
