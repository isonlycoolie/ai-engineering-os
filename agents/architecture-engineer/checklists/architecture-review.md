# Architecture Review Checklist

Complete before submitting ADR and implementation plan for human lead engineer review. Attach evidence (ADR link, OpenAPI spec, diagrams) for each applicable item.

**Feature / initiative:** _______________  
**ADR(s):** _______________  
**Reviewer:** _______________  
**Date:** _______________

---

## Requirements and Clarity (Stage 1)

- [ ] Feature specification read in full
- [ ] Acceptance criteria rewritten in testable terms where previously vague
- [ ] Non-functional requirements identified (scale, latency, availability, compliance)
- [ ] Ambiguities listed and resolved or escalated with human sign-off
- [ ] Human engineer signed off on approved feature specification before Stage 2

---

## ADR Completeness

- [ ] ADR created at `architecture/decisions/ADR-NNN-<title>.md`
- [ ] Status set to **Proposed** (not Accepted - human accepts)
- [ ] Context section describes situation, constraints, and forcing functions
- [ ] Decision stated clearly without ambiguity
- [ ] At least **two alternatives** documented with rejection rationale
- [ ] Consequences cover: easier, harder, new risks
- [ ] Review Date set for re-evaluation
- [ ] Related/superseded ADRs linked if applicable
- [ ] Reversibility classified (low / medium / high cost)

---

## Structural Design

- [ ] Blast radius documented - affected services, stores, queues, external systems
- [ ] Service boundaries respect bounded contexts - no shared DB coupling across services
- [ ] Default monolith respected unless ADR justifies service extraction
- [ ] Data flows mapped: ingress, processing, persistence, egress
- [ ] Consistency model explicit (strong vs eventual) with justification
- [ ] Failure modes analyzed: timeout, retry, circuit breaker, idempotency, degradation
- [ ] Stateless services preferred; state isolated in dedicated layers

---

## API Contract

- [ ] API contract defined **before** implementation handoff
- [ ] OpenAPI (or equivalent) checked in and linked from ADR
- [ ] Response envelope aligns with [`standards/api.md`](../../standards/api.md)
- [ ] Error codes are machine-readable with actionable messages
- [ ] URL versioning strategy documented (`/v1/`, deprecation plan if breaking)
- [ ] Idempotency strategy for mutating operations where duplicates are harmful

---

## Dependencies and Technology

- [ ] Every new external dependency justified in ADR
- [ ] Vendor lock-in and exit strategy documented
- [ ] License and supply chain risk considered
- [ ] Operational cost acknowledged (monitoring, on-call, upgrades)
- [ ] Technology choice driven by requirement - not preference alone

---

## Security (Design Layer)

- [ ] Authentication and authorization model defined for new surfaces
- [ ] Trust boundaries between services and external systems documented
- [ ] Data classification and storage location specified
- [ ] Public endpoint abuse surface considered (rate limiting design hook)

---

## Observability (Design Layer)

- [ ] Correlation ID propagation across service boundaries specified
- [ ] Metrics: request rate, error rate, latency per endpoint planned
- [ ] Health checks reflect dependency health - not only process uptime
- [ ] Structured logging fields align with [`standards/observability.md`](../../standards/observability.md)

---

## Tradeoffs and Simplicity

- [ ] Simplest design that satisfies requirements selected - or ADR explains why not
- [ ] No premature microservices, optimization, or abstraction without forcing function
- [ ] Tradeoff table used for significant decisions (see [`tradeoffs.md`](../tradeoffs.md))
- [ ] Equal options escalated to human - not decided silently

---

## Handoff Readiness

- [ ] Implementation plan linked with defined contracts
- [ ] QA can derive test boundaries from specification and contract
- [ ] Open questions and blockers listed with owners
