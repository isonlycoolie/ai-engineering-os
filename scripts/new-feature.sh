#!/usr/bin/env bash
# new-feature.sh — Create feature branch stub and feature-spec from template
set -euo pipefail

usage() {
  echo "Usage: $0 <feature-slug> [--branch]"
  echo ""
  echo "  <feature-slug>  lowercase kebab-case name (e.g. user-profile-export)"
  echo "  --branch        create and checkout git branch feature/<slug> (requires git repo)"
  echo ""
  echo "Creates:"
  echo "  docs/features/<slug>/feature-spec.md"
  echo "  docs/features/<slug>/BRANCH.txt  (suggested branch name)"
  exit 1
}

[[ $# -ge 1 ]] || usage

SLUG="$1"
CREATE_BRANCH=false
if [[ "${2:-}" == "--branch" ]]; then
  CREATE_BRANCH=true
fi

if [[ ! "$SLUG" =~ ^[a-z0-9]+(-[a-z0-9]+)*$ ]]; then
  echo "Error: slug must be lowercase kebab-case (e.g. refresh-token-rotation)"
  exit 1
fi

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TEMPLATE="$REPO_ROOT/templates/feature-spec.md"
FEATURE_DIR="$REPO_ROOT/docs/features/$SLUG"
SPEC_FILE="$FEATURE_DIR/feature-spec.md"
BRANCH_FILE="$FEATURE_DIR/BRANCH.txt"
BRANCH="feature/$SLUG"

if [[ ! -f "$TEMPLATE" ]]; then
  echo "Error: template not found at $TEMPLATE"
  exit 1
fi

if [[ -f "$SPEC_FILE" ]]; then
  echo "Error: $SPEC_FILE already exists"
  exit 1
fi

TITLE="$(echo "$SLUG" | tr '-' ' ' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2)}1')"
TODAY="$(date -u +%Y-%m-%d 2>/dev/null || date +%Y-%m-%d)"

mkdir -p "$FEATURE_DIR"

sed \
  -e "s/\[Feature Title\]/${TITLE}/g" \
  -e "s/feature\/<slug>/${BRANCH}/g" \
  -e "s/YYYY-MM-DD/${TODAY}/g" \
  "$TEMPLATE" > "$SPEC_FILE"

cat > "$BRANCH_FILE" <<EOF
$BRANCH
EOF

echo "Created: docs/features/${SLUG}/feature-spec.md"
echo "Created: docs/features/${SLUG}/BRANCH.txt"
echo "Suggested branch: $BRANCH"

if $CREATE_BRANCH; then
  if git -C "$REPO_ROOT" rev-parse --git-dir >/dev/null 2>&1; then
    if git -C "$REPO_ROOT" show-ref --verify --quiet "refs/heads/$BRANCH"; then
      git -C "$REPO_ROOT" checkout "$BRANCH"
      echo "Checked out existing branch: $BRANCH"
    else
      git -C "$REPO_ROOT" checkout -b "$BRANCH"
      echo "Created and checked out branch: $BRANCH"
    fi
  else
    echo "WARN: not a git repository — skipped --branch"
    exit 1
  fi
fi

echo ""
echo "Next: complete feature-spec.md and run Stage 1 (requirement clarity)."
