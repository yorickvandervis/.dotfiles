# Tool Routing

When to use opensrc vs other tools.

## Decision Tree

```
What are you exploring?
├─ Remote repository (GitHub/npm/PyPI/crates)
│   └─ Use opensrc_execute
│
├─ Local codebase (current project)
│   ├─ Find files by pattern → Use Glob
│   ├─ Search file contents → Use Grep
│   ├─ Read specific file → Use Read
│   └─ AST search → Use ast-grep tool
│
├─ Documentation lookup
│   ├─ Library docs → Use context7
│   └─ GitHub code examples → Use grep_app
│
└─ Web content
    └─ Use webfetch
```

## Tool Comparison

| Task | opensrc | Local Tools |
|------|---------|-------------|
| GitHub repos | Yes | No |
| npm packages | Yes | No |
| PyPI packages | Yes | No |
| crates.io | Yes | No |
| Current project | No | Yes |
| Stays server-side | Yes | N/A |

## When to Use opensrc

**Use opensrc when:**
- Exploring external libraries
- Comparing implementations across repos
- Understanding how a package works internally
- Finding patterns in open source code

**Don't use opensrc when:**
- Working with current project files
- Reading local files (use Read tool)
- Searching local code (use Grep/Glob)

## Complementary Tools

### context7 (MCP)

Query library documentation:
- API references
- Guides and tutorials
- Best practices

### grep_app (MCP)

Search real GitHub code:
- Find usage patterns
- Production examples
- Common implementations

### webfetch

Fetch web content:
- Documentation pages
- API specs
- Blog posts

## Workflow Example

Researching a new library:

1. **context7**: Query docs for overview
2. **grep_app**: Find real-world usage patterns
3. **opensrc**: Deep dive into implementation
4. **Local tools**: Apply learnings to your code

## Performance Notes

- opensrc keeps source trees server-side
- Only results are transferred
- Batch operations when possible
- Use `readMany` over multiple `read` calls
- Use globs in `files()` to filter early
