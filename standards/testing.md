# Testing Standards

## Pyramid

1. **Unit tests** - business logic, pure functions, validators
2. **Integration tests** - API to database, external service mocks
3. **E2E tests** - critical user workflows only

## Requirements

- Tests written alongside implementation, not after
- Happy path + at least two failure modes per feature
- Auth tested with authorized and unauthorized requests
- Tests assert behavior, not implementation details
- Never delete failing tests to pass CI

## Coverage

- Coverage must not decrease from previous release
- Critical paths: payments, auth, data mutation - 100% branch coverage target

## CI

- Full suite runs on every PR
- No merge with failing tests

## Agent Invocation

| Task | Agent / Prompt |
|------|----------------|
| Test specification (before code) | [stage-03-test-specification.md](../workflows/prompts/stage-03-test-specification.md) |
| Write tests | [qa-engineer/prompts/primary.md](../agents/qa-engineer/prompts/primary.md) |
| QA sign-off | [stage-06-qa-verification.md](../workflows/prompts/stage-06-qa-verification.md) |
| Regression after bug | [debugging-prompt.md](../prompts/debugging-prompt.md) |
