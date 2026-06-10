# Security - Review Checklist

Complete before security sign-off on an implementation or release.

## Authentication and Authorization

- [ ] All authentication flows follow established patterns - no custom cryptography
- [ ] Authorization is enforced at the service layer, not only the API gateway
- [ ] Every endpoint is authenticated unless explicitly justified and documented
- [ ] Session and token lifetimes follow project standards (short-lived access, refresh rotation)

## Input and Output

- [ ] All inputs are validated against a schema before processing
- [ ] All outputs are sanitized before rendering in a user interface
- [ ] File uploads validated for type, size, and storage path
- [ ] User-supplied URLs (webhooks, fetch) protected against SSRF

## Transport and Headers

- [ ] HTTPS is enforced on all endpoints
- [ ] Security headers configured: CSP, HSTS, X-Frame-Options, X-Content-Type-Options
- [ ] CORS is restrictive in production - no wildcard origins with credentials

## Abuse and Availability

- [ ] Rate limiting applied to all public endpoints
- [ ] Resource exhaustion paths considered (large payloads, expensive queries)

## Secrets and Dependencies

- [ ] Dependency audit shows no critical or high-severity vulnerabilities unaddressed
- [ ] Secrets stored in a vault and rotated on a defined schedule
- [ ] No secrets, tokens, or credentials in source code or version control
- [ ] Logs do not contain passwords, tokens, or PII

## Threat Modeling

- [ ] Threat model completed or updated for significant new features (`templates/threat-model.md`)
- [ ] Trust boundaries and attack paths reviewed for new entry points

## Findings and Sign-off

- [ ] All medium+ findings include attack-path evidence and remediation
- [ ] No unaddressed critical or high findings remain
- [ ] Human security engineer approval obtained
