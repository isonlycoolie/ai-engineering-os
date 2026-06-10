    $RoleTitle = ConvertTo-TitleCaseFromSlug -Slug $RoleSlug
}

$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$AgentDir = Join-Path (Join-Path $RepoRoot "agents") $RoleSlug

if (Test-Path $AgentDir) {
    Write-Error "Agent directory already exists: $AgentDir"
}

$dirs = @(
    $AgentDir,
    (Join-Path $AgentDir "prompts"),
    (Join-Path $AgentDir "templates"),
    (Join-Path $AgentDir "checklists")
)
foreach ($dir in $dirs) {
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
}

$RoleLower = $RoleTitle.ToLower()

function Write-AgentFile {
    param([string]$RelativePath, [string]$Content)
    Set-Content -Path (Join-Path $AgentDir $RelativePath) -Value $Content -Encoding utf8
}

Write-AgentFile "role.md" @"
# $RoleTitle Agent - Role Definition

## Purpose

Describe what this agent owns and the quality bar for its deliverables.

## Responsibilities

-

## Deliverables

-

## Boundaries

| In scope | Out of scope |
|----------|--------------|
| | |

## Collaboration

- Receives:
- Hands off to:

## Success Criteria

A deliverable is successful when it passes the pre-delivery checklist, meets the evidence bar in prompts, and a human engineer can explain every decision without unexplained trust.
"@

Write-AgentFile "instructions.md" @"
# $RoleTitle Agent - Working Instructions

Before producing output, this agent must:

1. Read the task specification and linked standards completely.
2. Read relevant existing code or documentation in the repository.
3. List all files or artifacts that will be created or modified.
4. Confirm the approach does not conflict with existing patterns or `tradeoffs.md`.
5. If any requirement is ambiguous, ask one precise clarifying question - stop until answered.
6. Produce output aligned with `role.md`, `limitations.md`, and applicable `standards/` docs.
7. Complete `checklists/pre-delivery.md` before handoff.
"@

Write-AgentFile "limitations.md" @"
# $RoleTitle Agent - Hard Limitations

This agent must never:

- Proceed past ambiguous requirements without surfacing them
- Merge, deploy, or push without explicit human instruction
- Make cross-cutting architectural decisions without human ADR approval
- Output secrets, credentials, or skip validation at trust boundaries
- Delete failing tests or checklists to pass a gate
"@

Write-AgentFile "coding-standards.md" @"
# $RoleTitle Agent - Coding Standards

Apply project standards in `standards/` plus role-specific rules below.

-

"@

Write-AgentFile "architecture-rules.md" @"
# $RoleTitle Agent - Architecture Rules

Structural constraints for this role. Escalate to Architecture Engineer when changes affect system topology.

-

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
