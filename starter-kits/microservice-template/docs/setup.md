# Setup - Microservice Template

## Prerequisites

- Node.js 20+
- npm 10+

## Local Development

```bash
cp .env.example .env
npm install
npm run dev
```

Verify: `curl http://localhost:3000/v1/health`

## Tests

```bash
npm test
```

## Docker

```bash
docker compose -f docker/docker-compose.yml up --build
```
