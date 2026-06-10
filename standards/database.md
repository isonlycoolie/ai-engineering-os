# Database Standards

## Schema Design

- Migrations versioned and reversible where possible
- Indexes planned for query patterns - not added as afterthought
- Foreign keys and constraints enforced at database level
- Soft delete vs hard delete documented per entity

## Queries

- Parameterized statements only
- No N+1 - use joins or batch loading
- Complex reporting queries may use raw SQL with review
- Transaction scope limited to related operations

## Migrations

- One logical change per migration
- Tested against copy of production schema in CI
- Backward-compatible deploys: expand → migrate → contract

## Agent Invocation

| Task | Agent |
|------|-------|
| Schema design | [architecture-engineer](../agents/architecture-engineer/) + ADR |
| Implement migrations | [backend-engineer/prompts/primary.md](../agents/backend-engineer/prompts/primary.md) |
| Query performance | [backend-engineer](../agents/backend-engineer/) + profiling evidence |
