# Skill Anatomy

Skill directory structures from minimal to complex.

## Directory Patterns

### Minimal Skill (SKILL.md Only)

```
my-skill/
└── SKILL.md
```

**When to use:**
- Instructions fit in <200 lines
- No external resources needed
- Simple procedural guidance

**Example:** Code review guidelines, commit message format, naming conventions.

### Simple Skill with Scripts

```
my-skill/
├── SKILL.md
└── scripts/
    └── validate.sh
```

**When to use:**
- Repeatable automation tasks
- Deterministic operations or tools (validation, conversion)
- Code that would be rewritten each time

**Example:** PDF processing, data validation, file format conversion.

### Reference-Heavy Skill

```
my-skill/
├── SKILL.md
└── references/
    ├── api.md
    ├── schemas.md
    └── examples.md
```

**When to use:**
- Domain knowledge model lacks
- Detailed specs/schemas needed
- Content too large for single file

**Example:** Internal API docs, database schemas, company policies.

### Complex Multi-File Skill

```
my-skill/
├── SKILL.md
├── references/
│   ├── workflow.md
│   └── troubleshooting.md
├── scripts/
│   └── deploy.sh
└── assets/
    └── template.yaml
```

**When to use:**
- Multi-step workflows
- Mix of documentation + automation
- Templates/boilerplate needed

**Example:** Release process, deployment pipeline, project scaffolding.

### Progressive Skill 

```
my-platform/
├── SKILL.md                    # Decision trees + navigation (~200 lines)
└── references/
    ├── product-a/
    │   ├── README.md           # Overview, quick start
    │   ├── api.md              # Runtime APIs
    │   ├── configuration.md    # Setup/config
    │   ├── patterns.md         # Best practices
    │   └── gotchas.md          # Pitfalls
    └── product-b/
        └── ... (same structure)
```

**When to use:**
- Large platforms (10+ products/features)
- Need to avoid loading everything at once
- Different products for different tasks

**Example:** AWS, GCP, Cloudflare, large internal platforms.

## File Size Guidelines

| File Type | Target | Max |
|-----------|--------|-----|
| SKILL.md | 150-200 lines | 500 lines |
| Reference file | 100-150 lines | 200 lines |
| Any single file | - | 500 lines |

**Why these limits?**
- Agent loads full file into context when reading
- Large files = context rot = worse performance
- Split content, not tokens

## Directory Naming

| Rule | Good | Bad |
|------|------|-----|
| Lowercase + hyphens | `my-skill` | `MySkill`, `my_skill` |
| Match `name:` field | `pdf-processor` | `pdf_proc` |
| Descriptive | `data-validator` | `util`, `helper` |
