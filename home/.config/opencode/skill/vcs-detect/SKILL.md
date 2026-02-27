---
name: vcs-detect
description: Detect version control system in use (git). Use before any VCS operations to determine which commands to use.
---

# VCS Detection Skill

Detect the version control system in use before running any VCS commands.

## Why This Matters

- Running wrong VCS commands causes errors
- Detection ensures correct CLI usage

## Detection Logic

`git rev-parse --show-toplevel` walks up the filesystem to find repo root.

**Check:**

1. `git rev-parse` succeeds → git
2. Fails → no VCS

## Detection Command

```bash
if git rev-parse --show-toplevel &>/dev/null; then echo "git"
else echo "none"
fi
```

## Command Reference

| Operation | git |
|-----------|-----|
| Status | `git status` |
| Log | `git log` |
| Diff | `git diff` |
| Commit | `git commit` |
| Branch list | `git branch` |
| New branch | `git checkout -b <name>` |
| Push | `git push` |
| Pull/Fetch | `git pull` / `git fetch` |
| Rebase | `git rebase` |

## Usage

Before any VCS operation:

1. Run detection command
2. Use appropriate CLI based on result
3. If `none`, warn user directory is not version controlled

## Example Integration

```
User: Show me the git log
Agent: [Runs detection] -> Result: git
Agent: [Runs `git log`]
```
