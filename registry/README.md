# Static Registry

Machine-readable index of AI Engineering OS assets for MCP remote fallback and CDN deploy.

## Build

```bash
pip install pyyaml
python scripts/build-registry.py
```

Output: `registry/dist/` (registry.json + markdown assets + index.html)

## Deploy (Render)

Use [render.yaml](render.yaml). Static publish path: `registry/dist`.

## Files

| File | Purpose |
|------|---------|
| [manifest.yaml](manifest.yaml) | Curated asset catalog with tags and dependsOn |
| [profiles/](profiles/) | Track bundles (frontend, backend, fullstack, single-task) |
| [index.html](index.html) | Landing page template |

## MCP

The MCP server loads `registry/dist/registry.json` locally or fetches from `os_registry_url`.
