# Next.js Enterprise Starter

Production-oriented starter kit: **Next.js 14+ App Router**, TypeScript, Tailwind CSS, and a
feature-based `src/` layout aligned with AI Engineering OS frontend standards.

> New to this repository? Start with [START-HERE.md](../../docs/START-HERE.md).

## What's included

- Feature-based architecture (`src/app/`, `src/features/`, `src/shared/`)
- Health check feature with TanStack Query hook and BFF route
- Shared HTTP client stub
- Vitest unit tests
- Docker + docker-compose
- GitHub Actions CI (lint, test, build)

## Quick start

```bash
npm install
cp .env.example .env.local
npm run dev
```

## Documentation

| Doc | Description |
|-----|-------------|
| [docs/setup.md](docs/setup.md) | Local development and scripts |
| [docs/architecture.md](docs/architecture.md) | Layer rules and data flow |
| [docs/deployment.md](docs/deployment.md) | Docker and production deployment |

## Standards

- Frontend architecture: [`agents/frontend-engineer/architecture-rules.md`](../../agents/frontend-engineer/architecture-rules.md)
- API envelope: [`standards/api.md`](../../standards/api.md)
