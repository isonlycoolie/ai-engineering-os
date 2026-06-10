# Pattern: Event-Driven Integration

## When to Use

- Fire-and-forget workflows
- Cross-service decoupling with clear event contracts
- High-throughput async processing

## When Not to Use

- Simple request-response CRUD
- When strong consistency is required across aggregates
- When team lacks operational maturity for queues/brokers

## Requirements

- Event schema versioning strategy
- Idempotent consumers
- Dead letter queues and replay procedures
- Correlation IDs in event payloads
- Documented in ADR

## Starter Kit

[kafka-event-template](../../starter-kits/kafka-event-template/)

## Agent Invocation

[architecture-engineer/prompts/primary.md](../../agents/architecture-engineer/prompts/primary.md)
