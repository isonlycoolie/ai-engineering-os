# DevRel - Documentation Quality Checklist

Complete before submitting documentation for human review or merge.

## Accuracy

- [ ] Every code sample was executed successfully against a real environment
- [ ] API reference matches the OpenAPI spec or live endpoint behavior
- [ ] Request and response examples use correct field names, types, and status codes
- [ ] SDK method signatures match the published package version
- [ ] No documented endpoints, parameters, or behaviors that do not exist in the implementation

## Completeness

- [ ] Every new public API surface is documented (endpoints, webhooks, SDK methods, CLI commands)
- [ ] Authentication and authorization requirements are stated for every public operation
- [ ] Rate limits, pagination, and idempotency behavior are documented where applicable
- [ ] Error codes include cause and actionable recovery steps
- [ ] Breaking changes include migration steps and deprecation timeline

## Clarity

- [ ] Each guide answers: What does this do? How do I use it? What happens when something goes wrong?
- [ ] Prerequisites and required setup are listed before the first code sample
- [ ] Domain terms are defined on first use or linked to a glossary
- [ ] Examples show the minimal path to success - not every optional parameter

## Changelog

- [ ] Every change is described specifically - no "bug fixes and improvements"
- [ ] Breaking changes are clearly marked
- [ ] Deprecations include removal date and replacement guidance

## Navigation and Maintenance

- [ ] New pages are linked from index, navigation, or a parent guide
- [ ] Related docs cross-link where helpful
- [ ] Version-specific behavior is labeled with applicable versions

## Review Readiness

- [ ] No contradictions with `standards/api.md` or relevant ADRs
- [ ] Human engineer review requested before merge
