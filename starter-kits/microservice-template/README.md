# Microservice Template

Production-oriented Node.js TypeScript microservice with health checks, structured logging, and an event bus interface stub.

Part of the [AI-Augmented Engineering OS](../../docs/START-HERE.md).

## Quick Start

```bash
cp .env.example .env
npm install
npm run dev
curl http://localhost:3000/v1/health
```

## Agents for Feature Work

| Stage | Agent |
|-------|-------|
| API implementation | [backend-engineer](../../agents/backend-engineer/) |
| Security review | [stage-05-security-review](../../workflows/prompts/stage-05-security-review.md) |
| Deploy | [sre-engineer](../../agents/sre-engineer/) |

## Documentation

- [docs/setup.md](docs/setup.md)
- [docs/architecture.md](docs/architecture.md)
- [docs/deployment.md](docs/deployment.md)
