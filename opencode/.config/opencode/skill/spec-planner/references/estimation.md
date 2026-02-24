# Estimation

## Why Estimates Fail

1. **Optimism bias**: We estimate for the happy path
2. **Scope creep**: Requirements grow during implementation
3. **Unknown unknowns**: We can't estimate what we don't know
4. **Anchoring**: First estimate sticks regardless of evidence
5. **Planning fallacy**: We underweight past experience

## Techniques

### T-Shirt Sizing

| Size | Meaning | Typical Duration |
|---|---|---|
| **S** | Well-understood, <3 files changed | Hours to 1 day |
| **M** | Some unknowns, 3-10 files | 1-3 days |
| **L** | Significant unknowns, new patterns | 3-7 days |
| **XL** | Research required, cross-cutting | 1-3 weeks |

### Three-Point Estimation

For any task, estimate:
- **Optimistic** (O): Everything goes right
- **Most likely** (M): Normal amount of friction
- **Pessimistic** (P): Major unexpected issues

**Expected** = (O + 4M + P) / 6

### Spike-First Strategy

If estimation confidence is <50%:
1. Timebox a spike (2-4 hours)
2. Build a throwaway prototype
3. Re-estimate with concrete knowledge
4. Decide whether to proceed

## Effort Multipliers

| Factor | Multiplier | Example |
|---|---|---|
| New technology | 1.5-2x | First time using a framework |
| Legacy code | 1.5-3x | No tests, unclear ownership |
| Cross-team dependency | 1.5-2x | Waiting on another team |
| Production data migration | 2-3x | Downtime risk, rollback planning |
| Security/compliance | 1.5-2x | Audit requirements |
| Documentation | 1.2-1.5x | If external docs required |

## Hidden Work Checklist

Don't forget to estimate:

- [ ] Error handling and edge cases
- [ ] Tests (unit, integration, e2e)
- [ ] Database migrations
- [ ] Config/environment changes
- [ ] Monitoring and alerting
- [ ] Documentation updates
- [ ] Code review cycles
- [ ] Deployment and verification
- [ ] Rollback plan

## When to Re-estimate

- After a spike reveals new information
- When scope changes (even "small" additions)
- At 50% of estimated time if progress is <30%
- When a key assumption proves wrong
