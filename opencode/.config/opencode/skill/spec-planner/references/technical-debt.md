# Technical Debt

## Categories

| Type | Description | Example |
|---|---|---|
| **Deliberate** | Conscious shortcut for speed | "Ship without tests, add later" |
| **Accidental** | Didn't know better at the time | Wrong abstraction discovered later |
| **Bit rot** | Code decays as requirements evolve | Feature flags never cleaned up |
| **Dependency** | External libraries drift | Major version behind, security patches |

## When to Pay Down

**Pay now if:**
- Debt is in the critical path of planned work
- Debt causes recurring incidents
- Debt blocks other high-priority work
- Compound interest is accelerating (getting worse each sprint)

**Pay later if:**
- Debt is in stable, rarely-changed code
- Cost to fix exceeds cost of living with it
- Area may be rewritten/deprecated soon

**Never pay if:**
- Code is scheduled for deletion
- Theoretical purity, no practical impact

## ROI Framework

For each debt item, estimate:

| Factor | Question |
|---|---|
| **Cost to fix** | How much effort to resolve? |
| **Cost to ignore** | How much ongoing pain? (incidents, slow velocity, bugs) |
| **Blast radius** | How many features/teams affected? |
| **Compound rate** | Is it getting worse over time? |

**Priority** = (Cost to ignore x Blast radius x Compound rate) / Cost to fix

## Refactoring Strategies

| Strategy | When | Risk |
|---|---|---|
| **Big bang** | Small blast radius, high test coverage | High if tests are weak |
| **Strangler fig** | Large system, can't stop the world | Low, but slower |
| **Branch by abstraction** | Need to swap implementations | Medium, requires discipline |
| **Parallel run** | Critical system, need confidence | Low, but expensive |

**Default to strangler fig** for anything larger than a single module.

## Tracking Debt

In specs and code:

```
// DEBT: [category] [description] [ticket/issue]
// Example:
// DEBT: accidental - UserService does auth + profile, split into two services (PROJ-123)
```

In planning:
- Maintain a debt backlog separate from feature backlog
- Review debt quarterly
- Allocate 10-20% of sprint capacity to debt reduction

## Communicating Debt to Stakeholders

| Don't say | Say instead |
|---|---|
| "We need to refactor" | "This change will reduce deploy failures by 50%" |
| "The code is messy" | "Adding features takes 3x longer in this area" |
| "We have technical debt" | "We're paying $X/sprint in workarounds and incidents" |
| "We need to rewrite" | "We can modernize incrementally while shipping features" |
