# scaffold-agent.ps1 - Generate a new agent folder from the AI Engineering OS agent contract
param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$RoleSlug,

    [Parameter(Position = 1)]
    [string]$RoleTitle = ""
)

$ErrorActionPreference = "Stop"

function ConvertTo-TitleCaseFromSlug {
    param([string]$Slug)
    ($Slug -split '-' | ForEach-Object {
        if ($_.Length -gt 0) {
            $_.Substring(0, 1).ToUpper() + $_.Substring(1)
        }
    }) -join ' '
}

function Get-PromptStub {
    param(
        [string]$RoleLower,
        [string]$Kind,
        [string]$Goal
    )

    @"
You are a $RoleLower working on the repository and task described in the project context below.
Apply the role constraints, standards, and checklists provided in context.
Treat the open workspace as the source of truth for code, conventions, and file paths.

Inherits [`global-system-prompt.md`](../../../prompts/global-system-prompt.md). Follow [`instructions.md`](../instructions.md) and [`limitations.md`](../limitations.md).

## Project context

[Developer provides: repo, paths, stack, ticket, acceptance criteria, files in scope]

## Goal

$Goal

## Scope

**In scope:**

-

**Out of scope:**

-

## Workflow

1. Read the task specification and linked context completely.
2. Read relevant existing code or documentation.
3. List artifacts to create or modify and state blast radius.
4. If any requirement is ambiguous, ask one precise clarifying question - stop until answered.
5. Execute the $Kind work per `instructions.md` and applicable standards.
6. Complete [`checklists/pre-delivery.md`](../checklists/pre-delivery.md).
7. Produce structured output per Response rules below.

## What to look for

**Prioritize:**

-

**Do not:**

-

## Evidence bar

Deliverable is complete when:

-

## Response rules

- Begin with a brief plan and any ambiguities found.
- End with summary, evidence, checklist status, and handoff notes.
- Do not merge, deploy, or push without explicit human instruction.
- Escalate to Architecture Engineer when an ADR is required.

## Constraints

From [`limitations.md`](../limitations.md):

- Never proceed past ambiguity silently
- Never output secrets or skip validation at trust boundaries
- Humans own architecture and final sign-off; this agent accelerates execution
"@
}

if ($RoleSlug -notmatch '^[a-z0-9]+(-[a-z0-9]+)*$') {
    Write-Error "role slug must be lowercase kebab-case (e.g. platform-engineer)"
}

if ([string]::IsNullOrWhiteSpace($RoleTitle)) {
