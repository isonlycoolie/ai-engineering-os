# Deployment - Microservice Template

## Container

Build from `docker/Dockerfile`. Runs as non-root user on port 3000.

## Environment Variables

| Variable | Required | Description |
|----------|----------|-------------|
| `PORT` | No | HTTP port (default 3000) |
| `SERVICE_NAME` | No | Log field identifier |
| `LOG_LEVEL` | No | Pino log level |
| `EVENT_BUS_DRIVER` | No | `memory` (stub) or future broker driver |

## Pre-Production

Complete [sre-engineer pre-production checklist](../../../agents/sre-engineer/checklists/pre-production.md) before first deploy.

## Health Check

Use `GET /v1/health` for load balancer and Kubernetes probes.
