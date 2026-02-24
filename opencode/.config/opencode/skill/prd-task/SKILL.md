---
name: prd-task
description: Convert markdown PRDs to executable JSON format. Use after creating a PRD with the prd skill to generate the prd.json for autonomous task completion.
---

# PRD Task Skill

Convert markdown PRDs to executable JSON format for autonomous task completion.

The PRD defines the **end state** via tasks with verification steps. The agent decides HOW to get there.

## Workflow

1. User requests: "Load the prd-task skill and convert prd-<name>.md"
2. Read the markdown PRD
3. Extract tasks with verification steps
4. Create `.opencode/state/<prd-name>/` directory
5. Move markdown PRD to `.opencode/state/<prd-name>/prd.md`
6. Output JSON to `.opencode/state/<prd-name>/prd.json`
7. Create empty `.opencode/state/<prd-name>/progress.txt`

State folder structure:
```
.opencode/state/<prd-name>/
├── prd.md       # Original markdown PRD (moved from project root)
├── prd.json     # Converted JSON for task execution
└── progress.txt # Empty file to track progress
```

## Output Format

```json
{
  "prdName": "<prd-name>",
  "tasks": [
    {
      "id": "functional-1",
      "category": "functional",
      "description": "User can register with email and password",
      "steps": [
        "POST /api/auth/register with valid email/password",
        "Verify 201 response with user object",
        "Verify password not in response",
        "Attempt duplicate email, verify 409"
      ],
      "passes": false
    }
  ],
  "context": {
    "patterns": ["API routes: src/routes/items.ts"],
    "keyFiles": ["src/db/schema.ts"],
    "nonGoals": ["OAuth/social login", "Password reset"]
  }
}
```

## Schema Details

### Task Object

| Field | Type | Description |
|-------|------|-------------|
| `id` | string | Unique identifier, e.g. "db-1", "api-auth" |
| `category` | string | Grouping: "functional", "ui", "api", "security", "testing" |
| `description` | string | What the task does when complete |
| `steps` | string[] | **Verification steps** - how to test it works |
| `passes` | boolean | Set to `true` when ALL steps verified |

### Key Points

- **Steps are verification, not implementation** - They describe HOW TO TEST, not how to build
- **Category is flexible** - Use what fits your codebase
- **Context helps agent explore** - Patterns and key files guide initial exploration

## Conversion Rules

### Task Sizing

Keep tasks small and focused:

- One logical change per task
- If a PRD section feels too large, break it into multiple tasks
- Each task should be completable in one commit

### Tasks from Markdown
- Each `### Title [category]` becomes a task
- Generate `id` as `<category>-<number>` or descriptive slug
- Text after title is the `description`
- Items under `**Verification:**` become `steps`
- `passes` always starts as `false`

### Context Preserved
- `context.patterns` - existing code patterns to follow
- `context.keyFiles` - files to explore first
- `context.nonGoals` - explicit scope boundaries

## Field Rules

**READ-ONLY except:**
- `passes`: Set to `true` when ALL verification steps pass

**NEVER edit or remove tasks** - This could lead to missing functionality.

## PRD Name

Derive from PRD title:
- `# PRD: User Authentication` -> `"prdName": "user-authentication"`

## After Conversion

Tell the user:

```
PRD converted and moved to .opencode/state/<prd-name>/
  - prd.md (moved from <original-path>)
  - prd.json (generated)
  - progress.txt (empty)

PRD: <prd-name>
Tasks: X total

To complete tasks:
  /complete-next-task <prd-name>
```
