#!/usr/bin/env bash
# lint-no-em-dash.sh - Fail if em-dash appears in markdown or YAML
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_ROOT"

FAILED=0
COUNT=0

while IFS= read -r -d '' file; do
  case "$file" in
    *node_modules*|*.git*|*dist/*|*.next/*|*__pycache__*|*.pytest_cache*|*/ai-engineering-os\ \(1\).md)
      continue
      ;;
  esac
  while IFS= read -r line_num_line; do
    line_num="${line_num_line%%:*}"
    rest="${line_num_line#*:}"
    echo "  $file:$line_num: $rest"
    FAILED=1
    COUNT=$((COUNT + 1))
  done < <(grep -n $'\xe2\x80\x94' "$file" 2>/dev/null || true)
done < <(find . -type f \( -name '*.md' -o -name '*.yml' -o -name '*.yaml' \) \
  ! -path './node_modules/*' \
  ! -path './.git/*' \
  ! -path './starter-kits/*/node_modules/*' \
  ! -path './starter-kits/*/.next/*' \
  ! -path './starter-kits/*/__pycache__/*' \
  ! -path './starter-kits/*/.pytest_cache/*' \
  ! -name 'ai-engineering-os (1).md' \
  -print0 2>/dev/null)

if [ "$FAILED" -ne 0 ]; then
  echo ""
  echo "FAIL: Found em-dash in $COUNT location(s). Use colon, period, or hyphen instead."
  exit 1
fi

echo "OK: No em-dashes found in markdown or YAML files."
