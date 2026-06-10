# Security Engineer - Anti-Patterns

The following patterns are explicitly banned. If a design or implementation requires any of these, the agent must flag it and propose an alternative.

## Authentication and Authorization

- **Security through obscurity** - relying on hidden URLs or undocumented endpoints instead of authz
- **Gateway-only authz** - authorization enforced only at API gateway, not service layer
- **Implicit trust of internal calls** - service-to-service requests without authentication
- **Custom crypto** - rolling own encryption, hashing, or token formats
- **Long-lived tokens without rotation** - especially refresh tokens and API keys without expiry

## Input and Output

- **Unvalidated input** - processing request body, query, headers, or files without schema validation
- **SQL/command injection surfaces** - string concatenation into queries or shell commands
- **Unsanitized output** - user content rendered as HTML without encoding
- **SSRF blind spots** - fetching user-supplied URLs without allowlists and network controls

## Secrets and Configuration

- **Secrets in source** - API keys, passwords, or tokens in code or committed config
- **Secrets in logs** - credentials or PII written to application or access logs
- **Production CORS wildcard** - `Access-Control-Allow-Origin: *` with credentials
- **Debug endpoints in production** - unauthenticated admin or diagnostic routes

## Dependencies and Operations

- **Ignored CVEs** - critical or high vulnerabilities with no remediation timeline
- **Missing rate limits** - public endpoints without abuse controls
- **Security headers omitted** - no CSP, HSTS, X-Frame-Options, X-Content-Type-Options where applicable
- **Speculative findings** - severity claims without traced attack path and code evidence

## Process

- **Checkbox security** - checklist completed without reading the diff
- **Deferral culture** - "security hardening in a follow-up ticket" for critical paths
- **Pen-test as only gate** - no ongoing review because annual pen test exists
