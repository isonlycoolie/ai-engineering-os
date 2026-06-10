#!/usr/bin/env bash
# validate-prompt-contract.sh — Verify all **/prompts/*.md files match PROMPT-CONTRACT.md
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

REQUIRED_SECTIONS=(
  "## Goal"
  "## Scope"
  "## Workflow"
  "## What to look for"
  "## Evidence bar"
  "## Response rules"
  "## Constraints"
)

EXCLUDE_FILES=(
  "PROMPT-CONTRACT.md"
  "PROMPT-REVIEW-CHECKLIST.md"
)

is_excluded() {
  local base="$1"
  local ex
  for ex in "${EXCLUDE_FILES[@]}"; do
    if [[ "$base" == "$ex" ]]; then
      return 0
    fi
  done
  return 1
}

failures=0
checked=0

while IFS= read -r -d '' file; do
  base="$(basename "$file")"
  if is_excluded "$base"; then
    continue
  fi

  checked=$((checked + 1))
  rel="${file#./}"
  missing=()

  for section in "${REQUIRED_SECTIONS[@]}"; do
    if ! grep -qF "$section" "$file"; then
      missing+=("$section")
    fi
  done

  if ((${#missing[@]} > 0)); then
    echo "FAIL: $rel"
    printf '  Missing: %s\n' "${missing[@]}"
    failures=$((failures + 1))
  fi
done < <(find . -path './.git' -prune -o -type f -path '*/prompts/*.md' -print0 | sort -z)

if ((failures > 0)); then
  echo ""
  echo "$failures file(s) failed prompt contract validation ($checked checked)."
  echo "See prompts/PROMPT-CONTRACT.md for required structure."
  exit 1
fi

if ((checked == 0)); then
  echo "WARN: No prompt files found under **/prompts/*.md"
  exit 0
fi

echo "OK: All $checked prompt file(s) pass contract validation."
