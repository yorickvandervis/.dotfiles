---
name: spec-planner
description: Dialogue-driven spec development through skeptical questioning. Use when planning features, migrations, or refactors that need thorough analysis before implementation.
license: MIT
metadata:
  author: dmmulroy
  version: "1.0.0"
---

# Spec Planner

Develop implementation-ready specs through iterative dialogue and skeptical questioning.

## When to Use

- Planning a new feature before implementation
- Evaluating migration or refactoring approaches
- Making architectural decisions with trade-offs
- Breaking down ambiguous requirements into concrete plans

## Philosophy

**Be the skeptical senior engineer.** Challenge assumptions, find edge cases, and push for clarity. The goal is a spec that survives contact with reality.

## Workflow

### Phase 1: CLARIFY

Understand what the user actually wants (not what they said).

1. Read the user's request carefully
2. Identify ambiguities, unstated assumptions, and missing context
3. Ask 3-5 pointed questions that expose the real requirements
4. **Do not proceed until you understand the problem space**

Questions to consider:
- What problem does this solve? For whom?
- What does success look like? How will you measure it?
- What's the simplest version that delivers value?
- What are the constraints (time, tech, team)?
- What happens if we do nothing?

### Phase 2: DISCOVER

Explore the codebase and gather technical context.

1. Search for existing patterns that relate to the task
2. Identify files, modules, and interfaces that will be affected
3. Find prior art — has something similar been attempted before?
4. Map dependencies and blast radius of changes
5. Note any technical debt that will affect the plan

### Phase 3: DRAFT

Write the spec using the appropriate template from @file references/templates.md.

**Every spec must include:**
- **Problem statement**: What's broken or missing (1-2 sentences)
- **Proposed approach**: How to fix it (concrete, not hand-wavy)
- **Scope**: What's in and what's explicitly out
- **Risks**: What could go wrong
- **Open questions**: What we still don't know

**Choose the right template:**
| Complexity | Template | When |
|---|---|---|
| Trivial | Quick Decision | Single choice, <1 day |
| Small | Feature Plan | 1-3 day feature |
| Medium | ADR | Architectural decision with trade-offs |
| Large | RFC | Cross-cutting change, needs buy-in |

### Phase 4: REFINE

Stress-test the draft.

1. **Red team your own spec**: What would a skeptic say?
2. **Check edge cases**: Empty states, error paths, concurrent access, rollback
3. **Estimate effort**: Use @file references/estimation.md framework
4. **Identify technical debt**: Use @file references/technical-debt.md to assess
5. **Apply decision frameworks**: Use @file references/decision-frameworks.md when choosing between options

### Phase 5: DONE

Deliver the final spec.

1. Present the spec to the user
2. Highlight key decisions and trade-offs
3. List unresolved questions that need human input
4. Suggest next steps (implementation order, who to involve)

## Anti-Patterns

- **Spec as novel**: If it's longer than 2 pages, it's too long. Cut ruthlessly.
- **Vague scope**: "Improve performance" is not a spec. "Reduce P99 latency of /api/search from 800ms to 200ms" is.
- **No exit criteria**: Every spec needs a definition of done.
- **Premature optimization**: Solve the problem first, optimize if measured.
- **Design by committee**: The spec should have a clear recommendation, not a menu of options.

## Output Format

```markdown
# [Feature/Decision Name]

## Problem
[1-2 sentences: what's broken or missing]

## Approach
[Concrete plan with enough detail to implement]

## Scope
**In scope**: [list]
**Out of scope**: [list]

## Design Decisions
[Key choices made and why]

## Risks
[What could go wrong and mitigations]

## Effort Estimate
[S/M/L/XL with brief justification]

## Open Questions
[Things that need human input]

## Next Steps
[Ordered list of implementation steps]
```

## In This Skill

| File | Purpose |
|---|---|
| [templates.md](./references/templates.md) | Spec templates by complexity |
| [decision-frameworks.md](./references/decision-frameworks.md) | Frameworks for evaluating options |
| [estimation.md](./references/estimation.md) | Effort estimation techniques |
| [technical-debt.md](./references/technical-debt.md) | Technical debt assessment |
