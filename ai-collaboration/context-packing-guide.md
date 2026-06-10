# Context Packing Guide

What to attach to AI prompts by task type.

## Always First: Project Context

Every session starts with a filled [project context template](../templates/project-context.md):

- Repository name and project root path
- Stack and track (frontend / backend / fullstack)
- Ticket ID and branch name
- Task summary and acceptance criteria
- Files in scope and out of scope

Agents work on **your open workspace**, not the OS repo. If you ran `install-ai-os`, attach standards from `.ai-os/standards/` in the project.

## New Feature Implementation

| Attachment | Why |
|------------|-----|
| **Project context** | Binds agent to your repo |
| Feature spec | Acceptance criteria |
| ADR (if any) | Structural constraints |
| Test spec | Expected behavior |
| Related source files | Pattern alignment |
| `coding-standards.md` for role | Quality bar |
| Global system prompt | Base constraints |

## Bug Fix

| Attachment | Why |
|------------|-----|
| Error message + stack trace | Reproduction |
| Structured logs (with request ID) | Context |
| Failing test | Expected vs actual |
| Affected module source | Fix scope |

## Code Review

| Attachment | Why |
|------------|-----|
| Full PR diff | Review scope |
| Linked issue/spec | Intent |
| Relevant standards | Compliance bar |

## Security Review

| Attachment | Why |
|------------|-----|
| PR diff | Changed surface |
| Auth/permission docs | Control baseline |
| Data flow diagram (if available) | Trust boundaries |

## Architecture

| Attachment | Why |
|------------|-----|
| Feature spec | Requirements |
| Existing ADRs | Prior decisions |
| System diagram | Current topology |
| ADR template | Output format |

## Documentation

| Attachment | Why |
|------------|-----|
| Working API or SDK | Source of truth |
| OpenAPI spec | Contract |
| Example consumer code | Idiomatic usage |

## Minimum Viable Context Rule

If you cannot attach at least: **what** (spec), **where** (files), and **how to verify** (tests/criteria), do not ask for implementation yet.
