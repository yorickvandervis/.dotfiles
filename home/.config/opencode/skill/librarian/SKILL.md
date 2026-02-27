---
name: librarian
description: Multi-repository codebase exploration. Research library internals, find code patterns, understand architecture, compare implementations across GitHub/npm/PyPI/crates. Use when needing deep understanding of how libraries work, finding implementations across open source, or exploring remote repository structure.
---

# Librarian Skill

Multi-repository codebase exploration using the opensrc MCP server.

## When to Use

- Exploring GitHub/npm/PyPI/crates repositories
- Understanding library internals
- Finding code patterns across repositories
- Comparing implementations
- Tracing code flow through unfamiliar libraries

## Tool: opensrc_execute

Single tool that executes JavaScript async functions server-side. Source trees stay on server, only results return.

## Quick Reference

| Operation | Example |
|-----------|---------|
| Fetch repo | `opensrc.fetch("vercel/ai")` |
| Fetch npm | `opensrc.fetch("zod")` |
| Fetch PyPI | `opensrc.fetch("pypi:requests")` |
| List sources | `opensrc.list()` |
| Read file | `opensrc.read(sourceName, "path/to/file.ts")` |
| Batch read | `opensrc.readMany(sourceName, ["a.ts", "b.ts"])` |
| Grep | `opensrc.grep("pattern", { sources: [name] })` |
| AST search | `opensrc.astGrep(sourceName, "useState($INIT)")` |
| File tree | `opensrc.tree(sourceName, { depth: 2 })` |
| List files | `opensrc.files(sourceName, "**/*.ts")` |

## Critical Pattern

**Always capture `source.name` from fetch results:**

```javascript
async () => {
  const [{ source }] = await opensrc.fetch("vercel/ai");
  // GitHub repos: "vercel/ai" → "github.com/vercel/ai"
  const sourceName = source.name;
  // Use sourceName for ALL subsequent calls
  return await opensrc.tree(sourceName, { depth: 2 });
}
```

## Reference Documentation

| File | Content |
|------|---------|
| [opensrc-api.md](./references/opensrc-api.md) | Full API reference |
| [opensrc-examples.md](./references/opensrc-examples.md) | Code examples |
| [tool-routing.md](./references/tool-routing.md) | When to use which tool |
| [diagrams.md](./references/diagrams.md) | Creating mermaid diagrams |
| [linking.md](./references/linking.md) | GitHub URL patterns |

## Fetch Spec Formats

| Format | Example | Source Name After Fetch |
|--------|---------|------------------------|
| npm | `"zod"` | `"zod"` |
| npm@version | `"zod@3.22.0"` | `"zod"` |
| PyPI | `"pypi:requests"` | `"requests"` |
| crates | `"crates:serde"` | `"serde"` |
| GitHub | `"vercel/ai"` | `"github.com/vercel/ai"` |
| GitHub@ref | `"vercel/ai@v1.0.0"` | `"github.com/vercel/ai"` |

## AST Pattern Syntax

| Pattern | Matches |
|---------|---------|
| `$NAME` | Single node, captures to metavars |
| `$$$ARGS` | Zero or more nodes (variadic) |
| `$_` | Single node, no capture |
| `$$$` | Zero or more nodes, no capture |

Examples:
- `console.log($$$ARGS)` - find all console.log calls
- `useState($INIT)` - find React useState
- `async function $NAME($$$PARAMS) { $$$BODY }` - find async functions
