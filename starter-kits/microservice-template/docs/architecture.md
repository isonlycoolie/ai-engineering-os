# Architecture - Microservice Template

## Overview

Single-purpose HTTP microservice with:

- Versioned routes under `/v1`
- Standard JSON envelope per [API standards](../../../standards/api.md)
- Structured JSON logging (Pino)
- Event bus interface with in-memory stub for local dev

## Event Bus

`src/events/bus.ts` defines `EventBus` interface. Replace `InMemoryEventBus` with Kafka/RabbitMQ adapter for production. See [event-driven pattern](../../../architecture/patterns/event-driven.md).

## Extension Points

- Add domain routes under `src/routes/`
- Wire broker in `createEventBus` for cross-service workflows
- Add OpenAPI spec per [backend-engineer](../../../agents/backend-engineer/)
