# Decision Frameworks

## Reversibility Matrix

| Decision Type | Reversibility | Approach |
|---|---|---|
| API contract | Low | Design carefully, get review |
| Database schema | Low | Migrate carefully, plan rollback |
| Library choice | Medium | Evaluate 2-3 options, prototype |
| Internal refactor | High | Just do it, iterate |
| UI layout | High | Ship and measure |

**Rule**: Spend decision effort proportional to irreversibility.

## Cost of Delay

Estimate the weekly cost of NOT doing this work:

| Impact | Weekly Cost | Priority |
|---|---|---|
| Revenue-blocking bug | $$$$ | Do now |
| Customer churn driver | $$$ | This sprint |
| Developer productivity | $$ | This quarter |
| Nice-to-have | $ | Backlog |

## RICE Scoring

| Factor | Scale | Question |
|---|---|---|
| **R**each | Users/month affected | How many people does this impact? |
| **I**mpact | 0.25 / 0.5 / 1 / 2 / 3 | How much does it improve their experience? |
| **C**onfidence | 0-100% | How sure are we about reach and impact? |
| **E**ffort | Person-months | How long will this take? |

**Score** = (Reach x Impact x Confidence) / Effort

## Technical Decision Checklist

Before choosing an approach, verify:

- [ ] Have you considered at least 2 alternatives?
- [ ] Can you articulate why NOT to choose each alternative?
- [ ] What's the rollback plan if this doesn't work?
- [ ] Does this create new dependencies? On what?
- [ ] Will this be obvious to a new team member in 6 months?
- [ ] What's the maintenance burden?

## Build vs Buy vs Adopt

| Factor | Build | Buy | Adopt (OSS) |
|---|---|---|---|
| Time to value | Slow | Fast | Medium |
| Customization | Full | Limited | Fork risk |
| Maintenance | You own it | Vendor owns it | Community + you |
| Cost | Dev time | License fees | Integration time |
| Risk | Scope creep | Vendor lock-in | Abandonment |

**Default to adopt** unless you have a strong reason not to.

## Decomposition Strategies

When a problem is too big:

1. **Vertical slice**: End-to-end for one use case, then expand
2. **Horizontal layer**: Build foundation, then features on top
3. **Strangler fig**: Replace piece by piece behind an interface
4. **Feature flag**: Ship dark, enable incrementally

**Prefer vertical slices** — they deliver value soonest and expose integration issues early.
