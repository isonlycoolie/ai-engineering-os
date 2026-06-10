# Setup

## Prerequisites

- Node.js 20+
- npm 10+

## Local development

```bash
cd starter-kits/nextjs-enterprise
cp .env.example .env.local
npm install
npm run dev
```

Open [http://localhost:3000](http://localhost:3000). The home page loads the health feature and calls `/api/health`.

## Scripts

| Command | Purpose |
|---------|---------|
| `npm run dev` | Start development server |
| `npm run build` | Production build |
| `npm run start` | Run production server |
| `npm run lint` | ESLint via Next.js |
| `npm run test` | Vitest unit tests |

## Environment variables

Copy `.env.example` to `.env.local` and adjust values. Only `NEXT_PUBLIC_*` variables are exposed to the browser.

## Docker

```bash
docker compose -f docker/docker-compose.yml up --build
```

The app listens on port 3000.
