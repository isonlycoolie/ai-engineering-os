#!/usr/bin/env python3
"""Build static registry dist for CDN deploy and MCP remote fallback."""
from __future__ import annotations

import hashlib
import json
import shutil
from datetime import datetime, timezone
from pathlib import Path

try:
    import yaml
except ImportError:
    yaml = None

REPO_ROOT = Path(__file__).resolve().parent.parent
MANIFEST = REPO_ROOT / "registry" / "manifest.yaml"
PROFILES_DIR = REPO_ROOT / "registry" / "profiles"
DIST = REPO_ROOT / "registry" / "dist"
INDEX_TEMPLATE = REPO_ROOT / "registry" / "index.html"


def load_manifest() -> dict:
    if yaml is None:
        raise SystemExit("PyYAML required: pip install pyyaml")
    with open(MANIFEST, encoding="utf-8") as f:
        return yaml.safe_load(f)


def sha256_file(path: Path) -> str:
    h = hashlib.sha256()
    with open(path, "rb") as f:
        for chunk in iter(lambda: f.read(8192), b""):
            h.update(chunk)
    return h.hexdigest()


def build() -> None:
    manifest = load_manifest()
    version = manifest.get("version", "1.0.0")

    if DIST.exists():
        shutil.rmtree(DIST)
    DIST.mkdir(parents=True)

    assets_out = []
    for asset in manifest.get("assets", []):
        src = REPO_ROOT / asset["path"]
        if not src.exists():
            print(f"WARN: missing {src}")
            continue
        dest = DIST / asset["path"]
        dest.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(src, dest)
        content_hash = sha256_file(dest)
        assets_out.append(
            {
                "id": asset["id"],
                "path": asset["path"].replace("\\", "/"),
                "url": f"/{asset['path'].replace(chr(92), '/')}",
                "track": asset.get("track", "shared"),
                "taskTypes": asset.get("taskTypes", []),
                "stage": asset.get("stage"),
                "dependsOn": asset.get("dependsOn", []),
                "sha256": content_hash,
            }
        )

    profiles_out = {}
    for profile_file in sorted(PROFILES_DIR.glob("*.json")):
        with open(profile_file, encoding="utf-8") as f:
            profiles_out[profile_file.stem] = json.load(f)

    registry = {
        "version": version,
        "builtAt": datetime.now(timezone.utc).isoformat(),
        "baseUrl": "",
        "assets": assets_out,
        "profiles": profiles_out,
    }

    with open(DIST / "registry.json", "w", encoding="utf-8") as f:
        json.dump(registry, f, indent=2)

    # Copy profiles for direct access
    profiles_dist = DIST / "profiles"
    profiles_dist.mkdir(exist_ok=True)
    for pf in PROFILES_DIR.glob("*.json"):
        shutil.copy2(pf, profiles_dist / pf.name)

    # index.html
    if INDEX_TEMPLATE.exists():
        html = INDEX_TEMPLATE.read_text(encoding="utf-8")
        html = html.replace("{{VERSION}}", version)
        html = html.replace("{{ASSET_COUNT}}", str(len(assets_out)))
        html = html.replace("{{BUILD_TIME}}", registry["builtAt"])
        (DIST / "index.html").write_text(html, encoding="utf-8")

    print(f"Built registry v{version}: {len(assets_out)} assets -> {DIST}")
    size_mb = sum(f.stat().st_size for f in DIST.rglob("*") if f.is_file()) / 1024 / 1024
    print(f"Dist size: {size_mb:.2f} MB")


if __name__ == "__main__":
    build()
