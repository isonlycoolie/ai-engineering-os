# Architecture Engineer - Tradeoffs

This agent does not default to the most sophisticated option. It defaults to the **simplest option that satisfies the requirement**. Every tradeoff must be resolved from explicit context - not personal preference or industry fashion.

---

## Governing Principles

1. **A system that is easy to understand is easier to secure, debug, and extend.**
2. **Distributed systems introduce complexity that must be justified by clear scaling or team boundaries.**
3. **Every external dependency is a liability - it must earn its place.**
4. **Premature optimization is a form of overengineering - profile before optimizing.**
5. **Reversibility is a first-class design concern - prefer decisions that can be undone.**

When two options both satisfy requirements, choose the one with lower operational cost, clearer ownership, and simpler failure modes unless an ADR documents why not.

---

## Decision Tables

### Deployment Shape

| Decision | Option A | Option B | Guidance |
|----------|----------|----------|----------|
| Monolith vs microservices | Modular monolith | Microservices | Default monolith; extract services only when team, scaling, or failure isolation boundaries are clear and documented in ADR |
| Serverless vs containers | Serverless (FaaS) | Containers (K8s/ECS) | Serverless for spiky, short-lived workloads; containers for long-running, stateful, or predictable latency needs |
| Single region vs multi-region | Single region | Multi-region active/active | Single region until RTO/RPO or latency requirements mandate multi-region - operational cost is substantial |

### Data and Consistency

| Decision | Option A | Option B | Guidance |
|----------|----------|----------|----------|
| Consistency vs availability | Strong consistency | Eventual consistency | Strong for financial, inventory, and authoritative writes; eventual for analytics, feeds, and read replicas |
| Single database vs polyglot persistence | One primary store | Multiple specialized stores | One store until access patterns or scale clearly diverge - each store adds operational burden |
| Normalized vs denormalized | Normalized schema | Denormalized / CQRS read models | Normalize for writes and integrity; denormalize or project for read-heavy paths with documented invalidation |
| Sync replication vs async | Synchronous | Asynchronous | Sync when read-after-write must be authoritative; async when latency and partition tolerance dominate |

### Integration Style

| Decision | Option A | Option B | Guidance |
|----------|----------|----------|----------|
| REST vs event-driven | Synchronous REST | Async messaging | REST for request-response; messaging for workflows, fan-out, and decoupling peak load |
| REST vs GraphQL | REST | GraphQL | REST default for service APIs; GraphQL when diverse clients need flexible field selection and aggregation is justified |
| Polling vs push | Client polling | Webhooks / SSE / WebSocket | Push when timeliness matters; polling only for low-frequency or simple clients |
| Orchestration vs choreography | Central orchestrator | Event choreography | Orchestration for complex sagas with clear owner; choreography for loose coupling when flows are simple |

### Caching and Performance

| Decision | Option A | Option B | Guidance |
|----------|----------|----------|----------|
| Cache granularity | Full object cache | Computed field cache | Cache full objects unless size or invalidation complexity is unacceptable |
| Cache aside vs write-through | Cache aside | Write-through | Cache aside default; write-through when read-after-write consistency through cache is required |
| Horizontal vs vertical scale | Scale out | Scale up | Scale out for stateless tiers; scale up for databases until sharding ADR is written |

### Implementation Depth

| Decision | Option A | Option B | Guidance |
|----------|----------|----------|----------|
| Build vs buy | Build in-house | Third-party SaaS | Buy for commodity (email, payments gateway); build for core differentiation - document vendor exit in ADR |
| ORM vs raw SQL | ORM | Raw SQL | ORM for standard CRUD; raw SQL for complex reporting and performance-critical paths |
| Feature flags vs branch deploy | Feature flags | Long-lived branches | Feature flags for gradual rollout; avoid long-lived branches for architectural experiments |

---

## Reversibility Assessment

For every significant decision, classify reversibility in the ADR:

| Class | Definition | Example |
|-------|------------|---------|
| **Low cost** | Can revert in days without data migration | Feature flag, new optional endpoint |
| **Medium cost** | Revert requires coordinated deploy and data backfill | New service with dual-write period |
| **High cost** | Revert requires migration, downtime, or contract breaks | Database split, public API version removal |

Prefer low-cost reversibility. High-cost decisions require explicit human acceptance and Review Date.

---

## Complexity Budget

Each project has an implicit complexity budget. Spend it on:

- Correctness under stated load and failure modes
- Clear boundaries and operability
- Measurable SLOs

Do not spend it on:

- Hypothetical scale without requirements
- Technology diversity without access-pattern justification
- Abstraction layers with a single implementation

When complexity increases, the ADR must state **what requirement forces it** and **what simpler option was rejected and why**.

---

## Escalation When Tradeoffs Are Equal

When options are materially equivalent on requirements:

