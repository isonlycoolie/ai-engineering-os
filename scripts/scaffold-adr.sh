#!/usr/bin/env bash
# scaffold-adr.sh — Create a numbered ADR from templates/adr.md
set -euo pipefail

usage() {
  echo "Usage: $0 <short-title-slug>"
  echo "Example: $0 modular-monolith-default"
  exit 1
}

[[ $# -ge 1 ]] || usage

SLUG="$1"
if [[ ! "$SLUG" =~ ^[a-z0-9]+(-[a-z0-9]+)*$ ]]; then
  echo "Error: slug must be lowercase kebab-case (e.g. api-versioning-strategy)"
  exit 1
fi

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DECISIONS_DIR="$REPO_ROOT/architecture/decisions"
TEMPLATE="$REPO_ROOT/templates/adr.md"

if [[ ! -f "$TEMPLATE" ]]; then
  echo "Error: template not found at $TEMPLATE"
  exit 1
fi

mkdir -p "$DECISIONS_DIR"

max=0
shopt -s nullglob
for f in "$DECISIONS_DIR"/ADR-[0-9][0-9][0-9]-*.md; do
  num="$(basename "$f" | sed -n 's/^ADR-\([0-9][0-9][0-9]\).*/\1/p')"
  if [[ -n "$num" ]]; then
    num=$((10#$num))
    if (( num > max )); then max=$num; fi
  fi
done
shopt -u nullglob

next=$((max + 1))
padded="$(printf '%03d' "$next")"
OUT="$DECISIONS_DIR/ADR-${padded}-${SLUG}.md"

if [[ -f "$OUT" ]]; then
  echo "Error: $OUT already exists"
  exit 1
fi

TITLE="$(echo "$SLUG" | tr '-' ' ' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2)}1')"

sed \
  -e "s/ADR-NNN/ADR-${padded}/g" \
  -e "s/\[Decision Title\]/${TITLE}/g" \
  "$TEMPLATE" > "$OUT"

echo "Created: architecture/decisions/ADR-${padded}-${SLUG}.md"
echo "Next: fill Context, Decision, and Alternatives — set Status to Proposed until human accepts."
