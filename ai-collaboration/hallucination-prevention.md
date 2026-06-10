# Hallucination Prevention

AI agents produce incorrect output. This is a known property, not an exception.

## Practices

- Never rely on an agent to recall API contracts, library versions, or configs from memory - provide source of truth in the prompt
- Test every code sample before trusting it
- Verify external system facts against official documentation
- Treat difficult-to-verify output with higher skepticism
- The more confident an agent sounds, the more carefully review the output

## High-Risk Areas

| Area | Mitigation |
|------|------------|
| Library APIs | Pin version in prompt; attach docs or existing usage |
| Config/env vars | Attach `.env.example` and config files |
| Database schema | Attach migrations and models |
| Auth flows | Attach ADR and existing auth module |
| Third-party SDKs | Attach official doc links or working examples |

## Stop Conditions

Escalate to human review when:

- Agent invents file paths or functions that do not exist
- Agent cites deprecated APIs without evidence
- Tests pass only because assertions were weakened
- Agent refuses to cite evidence for security claims

See [prompt-anti-patterns.md](prompt-anti-patterns.md).
