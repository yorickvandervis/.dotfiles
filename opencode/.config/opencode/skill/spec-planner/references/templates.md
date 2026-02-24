# Spec Templates

## Quick Decision

For trivial decisions (<1 day effort).

```markdown
# Decision: [Title]

**Context**: [1 sentence on why this decision is needed]
**Decision**: [What we're doing]
**Alternatives considered**: [Brief list]
**Why this one**: [1-2 sentences]
```

## Feature Plan

For small features (1-3 days).

```markdown
# Feature: [Title]

## Problem
[What's broken or missing — 1-2 sentences]

## Approach
[How to solve it — concrete steps]

### Changes Required
- [ ] [File/module]: [What changes]
- [ ] [File/module]: [What changes]

## Scope
**In**: [What's included]
**Out**: [What's explicitly excluded]

## Risks
- [Risk 1]: [Mitigation]

## Estimate
[S/M/L] — [Brief justification]

## Done When
- [ ] [Acceptance criterion 1]
- [ ] [Acceptance criterion 2]
```

## Architecture Decision Record (ADR)

For decisions with significant trade-offs.

```markdown
# ADR-[number]: [Title]

**Status**: [Proposed | Accepted | Deprecated | Superseded]
**Date**: [YYYY-MM-DD]
**Deciders**: [Who was involved]

## Context
[What forces are at play? What problem are we solving?]

## Decision
[What we decided to do and why]

## Alternatives Considered

### Option A: [Name]
- **Pros**: [list]
- **Cons**: [list]
- **Effort**: [S/M/L/XL]

### Option B: [Name]
- **Pros**: [list]
- **Cons**: [list]
- **Effort**: [S/M/L/XL]

## Consequences

### Positive
- [Benefit 1]
- [Benefit 2]

### Negative
- [Trade-off 1]
- [Trade-off 2]

### Risks
- [Risk 1]: [Mitigation]

## Review Date
[When to revisit this decision]
```

## RFC (Request for Comments)

For cross-cutting changes that need broader input.

```markdown
# RFC: [Title]

**Author**: [Name]
**Date**: [YYYY-MM-DD]
**Status**: [Draft | In Review | Accepted | Rejected]
**Reviewers**: [Who should review]

## Summary
[2-3 sentence overview]

## Motivation
[Why is this needed? What problem does it solve?]

## Detailed Design

### Architecture
[How it works at a high level]

### API / Interface Changes
[What changes for consumers]

### Data Model Changes
[Schema changes, migrations]

### Migration Plan
[How to get from here to there]

## Drawbacks
[Why might we NOT want to do this?]

## Alternatives
[Other approaches considered and why they were rejected]

## Unresolved Questions
[What still needs to be figured out?]

## Implementation Plan
1. [Phase 1]: [Description] — [Estimate]
2. [Phase 2]: [Description] — [Estimate]
3. [Phase 3]: [Description] — [Estimate]
```

## Handoff Artifact

When handing off to another developer or team.

```markdown
# Handoff: [Feature/Task Name]

## Current State
[What's been done, what's left]

## Key Decisions Made
1. [Decision]: [Why]

## Known Issues
- [Issue 1]: [Context]

## Files to Know
| File | Purpose |
|---|---|
| [path] | [what it does] |

## How to Test
[Commands and steps to verify]

## Gotchas
- [Thing that might trip you up]

## Questions for Next Developer
- [Open question 1]
```
