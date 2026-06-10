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

