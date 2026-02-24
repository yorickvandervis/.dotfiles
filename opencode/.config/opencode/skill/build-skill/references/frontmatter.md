# YAML Frontmatter Specification

Every SKILL.md must begin with YAML frontmatter.

## Required Format

```yaml
---
name: skill-name
description: What this skill does and when to use it.
---
```

**Critical:** Frontmatter must start at line 1. No blank lines before `---`.

## Required Fields

### name

| Constraint | Value |
|------------|-------|
| Required | Yes |
| Max length | 64 characters |
| Pattern | `^[a-z0-9]+(-[a-z0-9]+)*$` |
| Must match | Directory name |

**Rules:**
- Lowercase letters, numbers, hyphens only
- Cannot start or end with hyphen
- No consecutive hyphens (`--`)
- Must match parent directory name

**Good names:**
- `analyzing-data`
- `managing-releases`
- `code-review`
- `bigquery-analytics`

**Bad names:**
- `helper` (too vague)
- `utils` (meaningless)
- `MySkill` (uppercase)
- `pdf_processor` (underscores)

### description

| Constraint | Value |
|------------|-------|
| Required | Yes |
| Max length | 1024 characters |
| Min recommended | 50 characters |

**Rules:**
- Write in third person ("Processes files" not "I process files")
- Include WHAT the skill does
- Include WHEN to use it (activation triggers)
- Be specific with key terms

**Good descriptions:**

```yaml
# PDF skill
description: Extract text and tables from PDF files, fill forms, merge documents. Use when working with PDF files or asked to read/edit PDFs.

# Code review skill
description: Review pull requests for quality, security, and test coverage. Use when asked to review a PR or diff.
```

**Bad descriptions:**

```yaml
description: Helps with files          # Too vague
description: I can help you with data  # Wrong POV
description: PDF tool                  # No trigger context
```

## Optional Fields

### license

```yaml
license: Apache-2.0
```

### compatibility

```yaml
compatibility: Requires git, docker, and jq installed. macOS/Linux only.
```

### metadata

```yaml
metadata:
  author: dmmulroy
  version: "1.0"
  team: platform
```

## Validation Checklist

| Check | Requirement |
|-------|-------------|
| Starts with `---` | Line 1, no preceding blank lines |
| Has `name:` | Required |
| Name format | Lowercase, hyphens, no `--`, no leading/trailing `-` |
| Name matches dir | `my-skill/SKILL.md` has `name: my-skill` |
| Has `description:` | Required |
| Description quality | 50+ chars, third person, includes triggers |
| Closes with `---` | Required |
