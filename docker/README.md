# Docker

Base images and local development compose patterns for services in the AI Engineering OS ecosystem.

## Layout

```
docker/
├── node-base/          # Shared Node.js runtime image
├── python-base/        # Shared Python runtime image
└── compose/
    └── dev-compose.yml # Local multi-service stack pattern
```

## Base images

| Image | Purpose | Build |
|-------|---------|-------|
| `node-base` | API and frontend build/runtime | `docker build -f docker/node-base/Dockerfile -t org/node-base:latest .` |
| `python-base` | Workers, ML, scripting services | `docker build -f docker/python-base/Dockerfile -t org/python-base:latest .` |

Base images should:

- Run as a non-root user
- Pin base image digests in production builds
- Include only runtime dependencies (multi-stage builds for compiled artifacts)
- Expose a health check endpoint or `HEALTHCHECK` instruction where applicable

## Local development

```bash
# From repository root
docker compose -f docker/compose/dev-compose.yml up --build
```

Adjust service definitions, ports, and volume mounts in `compose/dev-compose.yml` as application services are added.

## Production guidance

- Tag images with immutable digests and semantic versions (`v1.2.3`, not `latest` alone)
- Scan images in CI (see `.github/workflows/security-scan.yml`)
- Set resource limits and read-only root filesystem where supported
- Inject secrets via orchestrator secrets, not environment files in images

## Related documentation

- [Observability standards](../standards/observability.md)
- [SRE pre-production checklist](../agents/sre-engineer/checklists/pre-production.md)
