#!/usr/bin/env bash
# install-ai-os.sh - Copy minimal OS rule set into a target project
set -euo pipefail

if [ $# -lt 1 ]; then
  echo "Usage: $0 <target-project-path>"
  exit 1
fi

TARGET="$(cd "$1" && pwd)"
OS_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
OS_DEST="$TARGET/.ai-os"

echo "Installing AI Engineering OS into: $TARGET"
mkdir -p "$OS_DEST"

for dir in agents prompts standards ai-collaboration; do
  if [ -d "$OS_ROOT/$dir" ]; then
    mkdir -p "$OS_DEST/$dir"
    cp -R "$OS_ROOT/$dir/." "$OS_DEST/$dir/"
    echo "  Copied $dir/"
  fi
done

if [ -d "$OS_ROOT/workflows/prompts" ]; then
  mkdir -p "$OS_DEST/workflows/prompts"
  cp -R "$OS_ROOT/workflows/prompts/." "$OS_DEST/workflows/prompts/"
  echo "  Copied workflows/prompts/"
fi

if [ -d "$OS_ROOT/agents/shared" ]; then
  mkdir -p "$OS_DEST/agents/shared"
  cp -R "$OS_ROOT/agents/shared/." "$OS_DEST/agents/shared/"
  echo "  Copied agents/shared/"
fi

if [ -d "$OS_ROOT/registry" ]; then
  mkdir -p "$OS_DEST/registry"
  cp "$OS_ROOT/registry/manifest.yaml" "$OS_DEST/registry/" 2>/dev/null || true
  cp -R "$OS_ROOT/registry/profiles" "$OS_DEST/registry/" 2>/dev/null || true
  cp -R "$OS_ROOT/registry/dist" "$OS_DEST/registry/" 2>/dev/null || true
  echo "  Copied registry/"
fi

if [ ! -f "$TARGET/ai-os.config.yaml" ]; then
  cp "$OS_ROOT/templates/ai-os.config.yaml" "$TARGET/ai-os.config.yaml"
  echo "  Created ai-os.config.yaml"
fi

mkdir -p "$TARGET/docs"
cp "$OS_ROOT/templates/project-context.md" "$TARGET/docs/project-context.md"
echo "  Created docs/project-context.md"

echo ""
echo "Done. Open $TARGET in your IDE and use docs/project-context.md for each AI session."
