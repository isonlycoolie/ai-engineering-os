# Prompts

## Implement a feature

```
Use ./frontend-ai-os while implementing [FEATURE].

Context: [ticket, acceptance criteria, API contract, design link]
Match existing project conventions. Do not change folder architecture.
Deliver: implementation + tests + checklist verification.
```

## Fix a UI bug

```
Use ./frontend-ai-os/checklist.md and standards.md.
Bug: [description]. Reproduce first, then fix root cause. Add regression test if feasible.
```

## Accessibility review

```
Review [component/page] against frontend-ai-os/standards.md accessibility section.
List violations with severity and concrete fixes.
```

## PR review

```
Review this UI PR using frontend-ai-os/standards.md and checklist.md.
Flag: a11y, missing async states, validation gaps, API misuse, test gaps.
```
