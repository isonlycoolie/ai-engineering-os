#!/usr/bin/env bash
# scaffold-agent.sh — Generate a new agent folder from the AI Engineering OS agent contract
set -euo pipefail

usage() {
  echo "Usage: $0 <role-slug> [\"Role Title\"]"
  echo "Example: $0 data-engineer \"Data Engineer\""
  exit 1
}

[[ $# -ge 1 ]] || usage

ROLE_SLUG="$1"
ROLE_TITLE="${2:-$(echo "$ROLE_SLUG" | tr '-' ' ' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2)}1')}"

if [[ ! "$ROLE_SLUG" =~ ^[a-z0-9]+(-[a-z0-9]+)*$ ]]; then
  echo "Error: role slug must be lowercase kebab-case (e.g. platform-engineer)"
  exit 1
fi

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
AGENT_DIR="$REPO_ROOT/agents/$ROLE_SLUG"

if [[ -e "$AGENT_DIR" ]]; then
  echo "Error: $AGENT_DIR already exists"
  exit 1
fi

mkdir -p "$AGENT_DIR"/{prompts,templates,checklists}

write_file() {
  local path="$1"
  shift
  cat > "$path"
}

write_file "$AGENT_DIR/role.md" <<EOF
# ${ROLE_TITLE} Agent — Role Definition

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
EOF

write_file "$AGENT_DIR/instructions.md" <<EOF
# ${ROLE_TITLE} Agent — Working Instructions

Before producing output, this agent must:

1. Read the task specification and linked standards completely.
2. Read relevant existing code or documentation in the repository.
3. List all files or artifacts that will be created or modified.
4. Confirm the approach does not conflict with existing patterns or \`tradeoffs.md\`.
5. If any requirement is ambiguous, ask one precise clarifying question — stop until answered.
6. Produce output aligned with \`role.md\`, \`limitations.md\`, and applicable \`standards/\` docs.
7. Complete \`checklists/pre-delivery.md\` before handoff.
EOF

write_file "$AGENT_DIR/limitations.md" <<EOF
# ${ROLE_TITLE} Agent — Hard Limitations

This agent must never:

- Proceed past ambiguous requirements without surfacing them
- Merge, deploy, or push without explicit human instruction
- Make cross-cutting architectural decisions without human ADR approval
- Output secrets, credentials, or skip validation at trust boundaries
- Delete failing tests or checklists to pass a gate
EOF

write_file "$AGENT_DIR/coding-standards.md" <<EOF
# ${ROLE_TITLE} Agent — Coding Standards

Apply project standards in \`standards/\` plus role-specific rules below.

-

EOF

write_file "$AGENT_DIR/architecture-rules.md" <<EOF
# ${ROLE_TITLE} Agent — Architecture Rules

Structural constraints for this role. Escalate to Architecture Engineer when changes affect system topology.

-

EOF

write_file "$AGENT_DIR/anti-patterns.md" <<EOF
# ${ROLE_TITLE} Agent — Anti-Patterns

Explicitly banned patterns. Flag and propose alternatives before handoff.

| Anti-pattern | Why it is banned | Alternative |
|--------------|------------------|-------------|
| | | |
EOF

write_file "$AGENT_DIR/tradeoffs.md" <<EOF
# ${ROLE_TITLE} Agent — Tradeoff Guidance

Select options from explicit context — not preference. Default to the simplest option that satisfies the requirement.

| Decision | Option A | Option B | Guidance |
|----------|----------|----------|----------|
| | | | |
EOF

write_file "$AGENT_DIR/checklists/pre-delivery.md" <<EOF
# ${ROLE_TITLE} — Pre-Delivery Checklist

Complete before handoff to human review or the next agent.

## Scope and requirements

- [ ] Task specification and acceptance criteria read in full
- [ ] All in-scope requirements addressed or explicitly flagged as out of scope

## Quality

- [ ] Output aligns with \`standards/\` and role instructions
- [ ] Evidence bar from \`prompts/primary.md\` met

## Handoff

- [ ] Open questions and risks documented
- [ ] Recommended next step named (agent role or human)

---

| Role | Name | Date | Decision |
|------|------|------|----------|
| ${ROLE_TITLE} (agent) | | | Ready for review |
| Human reviewer | | | Approved / Changes required |
EOF

write_file "$AGENT_DIR/templates/deliverable.md" <<EOF
# ${ROLE_TITLE} Deliverable

| Field | Value |
|-------|-------|
| **Feature / task** | |
| **Author (agent run)** | ${ROLE_SLUG} |
| **Date** | YYYY-MM-DD |

## Summary

## Changes

## Evidence

## Open questions

## Handoff
EOF

ROLE_LOWER="$(echo "$ROLE_TITLE" | tr '[:upper:]' '[:lower:]')"

prompt_stub() {
  local kind="$1"
  local goal="$2"
  cat <<EOF
You are a ${ROLE_LOWER} working on the repository and task described in the project context below.
Apply the role constraints, standards, and checklists provided in context.
Treat the open workspace as the source of truth for code, conventions, and file paths.

Inherits [\`global-system-prompt.md\`](../../../prompts/global-system-prompt.md). Follow [\`instructions.md\`](../instructions.md) and [\`limitations.md\`](../limitations.md).

## Project context

[Developer provides: repo, paths, stack, ticket, acceptance criteria, files in scope]

## Goal

${goal}

## Scope

**In scope:**

-

**Out of scope:**

-

## Workflow

1. Read the task specification and linked context completely.
2. Read relevant existing code or documentation.
3. List artifacts to create or modify and state blast radius.
4. If any requirement is ambiguous, ask one precise clarifying question — stop until answered.
5. Execute the ${kind} work per \`instructions.md\` and applicable standards.
6. Complete [\`checklists/pre-delivery.md\`](../checklists/pre-delivery.md).
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

From [\`limitations.md\`](../limitations.md):

- Never proceed past ambiguity silently
- Never output secrets or skip validation at trust boundaries
- Humans own architecture and final sign-off; this agent accelerates execution
EOF
}

prompt_stub "primary" "Deliver production-ready ${ROLE_LOWER} output that passes the pre-delivery checklist and meets the task evidence bar." \
  > "$AGENT_DIR/prompts/primary.md"

prompt_stub "review" "Review ${ROLE_LOWER} work against standards, the task spec, and the evidence bar — with actionable findings." \
  > "$AGENT_DIR/prompts/review.md"

prompt_stub "handoff" "Produce a complete handoff package so the next human engineer or agent can continue without re-discovering context." \
  > "$AGENT_DIR/prompts/handoff.md"

echo "Created agent: agents/${ROLE_SLUG}/"
echo ""
echo "Structure:"
find "$AGENT_DIR" -type f | sed "s|$REPO_ROOT/||" | sort
echo ""
echo "Next steps:"
echo "  1. Edit role.md, instructions.md, and limitations.md"
echo "  2. Customize prompts/primary.md, review.md, handoff.md"
echo "  3. Run: scripts/validate-prompt-contract.sh"
