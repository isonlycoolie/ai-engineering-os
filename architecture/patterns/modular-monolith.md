# Pattern: Modular Monolith

## When to Use

Default architecture for new systems until team or scaling boundaries justify extraction.

## Structure

- Single deployable unit
- Modules bounded by domain (users, billing, notifications)
- Modules communicate via internal interfaces, not HTTP between "services"
- Shared database acceptable with schema separation per module

## Benefits

- Simple operations, debugging, and transactions
- Lower infrastructure cost
- Easier to secure and observe

## Extraction Criteria

Extract a module to a separate service when:

- Independent scaling requirement with evidence
- Separate team owns the module with clear API contract
- Deployment cadence must diverge

## Agent Invocation

[architecture-engineer/prompts/primary.md](../../agents/architecture-engineer/prompts/primary.md)
