# Deployment

## Build artifact

Next.js is configured with `output: 'standalone'` for container-friendly deployments.

```bash
npm run build
npm run start
```

## Docker

Build and run from the project root:

```bash
docker compose -f docker/docker-compose.yml up --build -d
```

The multi-stage `docker/Dockerfile` produces a minimal runtime image with the standalone server.

## CI

GitHub Actions workflow (`.github/workflows/ci.yml`) runs lint, test, and build on push/PR to `main`.

Adjust the workflow path if this kit is copied into a standalone repository - move the workflow to
`.github/workflows/ci.yml` at the repo root and remove the `working-directory` override.

## Production checklist

- [ ] Set environment variables in the hosting platform
- [ ] Configure health checks against `/api/health`
- [ ] Enable HTTPS and security headers at the edge
- [ ] Wire observability (request tracing, error reporting)

## Platform notes

| Platform | Notes |
|----------|-------|
| Vercel | Zero-config for Next.js; set env vars in project settings |
| Kubernetes | Use the Docker image; probe `/api/health` |
| AWS ECS/Fargate | Push image to ECR; map port 3000 |
