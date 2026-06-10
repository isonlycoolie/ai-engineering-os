# Pattern: API Versioning

## Strategy

URL path versioning: `/v1/`, `/v2/`

## Rules

- Breaking changes require new major version
- Minimum 90-day deprecation for old versions
- Deprecation: `Sunset` header + changelog + client notification
- Non-breaking additions allowed in current version

## Breaking Changes

- Removing or renaming fields
- Changing field types or semantics
- Changing auth requirements
- Changing error codes for same condition

## Agent Invocation

[standards/api.md](../../standards/api.md), [architecture-prompt.md](../../prompts/architecture-prompt.md)
