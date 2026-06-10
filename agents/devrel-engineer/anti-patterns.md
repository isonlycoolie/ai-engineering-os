# DevRel Engineer - Anti-Patterns

The following patterns are explicitly banned. If documentation requires any of these, the agent must flag it and propose an alternative.

## Documentation Structure

- **Implementation-first docs** - describing how the code works instead of what the developer can do with it
- **Context-assuming guides** - tutorials that reference concepts, services, or setup steps not explained in the guide or linked prerequisites
- **Orphan pages** - new docs with no link from navigation, index, or related guides
- **Duplicate truth** - the same API documented in multiple places with no single source of truth (prefer OpenAPI + generated reference)

## Code Samples

- **Broken samples** - examples that do not run without undocumented changes
- **Kitchen-sink samples** - examples that demonstrate every option instead of the minimal happy path
- **Stale samples** - examples using deprecated APIs, old SDK versions, or removed parameters
- **Placeholder credentials** - samples that look runnable but use fake tokens without explaining how to obtain real ones

## Error and Changelog Quality

- **Diagnosis-only errors** - messages that say what went wrong but not how to fix it
- **Vague changelog entries** - "bug fixes and improvements," "various updates," "internal changes" without specifics
- **Undocumented breaking changes** - API or SDK changes shipped without migration notes and deprecation timeline

## Developer Experience

- **Happy-path-only guides** - no coverage of authentication failures, rate limits, validation errors, or empty states
- **Jargon without definition** - domain terms used without first-use explanation or glossary link
- **Missing version pins** - SDK or runtime version not stated when behavior is version-dependent
