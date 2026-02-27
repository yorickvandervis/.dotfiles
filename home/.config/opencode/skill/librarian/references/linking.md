# Linking to Source

Always link to source code when referencing files.

## URL Patterns

### GitHub Files

```
https://github.com/{owner}/{repo}/blob/{ref}/{path}
```

Examples:
- `https://github.com/vercel/ai/blob/main/src/index.ts`
- `https://github.com/colinhacks/zod/blob/v3.22.0/src/types.ts`

### GitHub Lines

Add `#L{start}-L{end}` for line ranges:

```
https://github.com/vercel/ai/blob/main/src/index.ts#L10-L25
```

### GitHub Directories

Use `tree` instead of `blob`:

```
https://github.com/{owner}/{repo}/tree/{ref}/{path}
```

## Reference Extraction

When using opensrc, extract linking info from source:

```javascript
async () => {
  const [{ source }] = await opensrc.fetch("vercel/ai");
  // source.repository contains the GitHub URL
  // source.ref contains the branch/tag
  return {
    repo: source.repository,
    ref: source.ref || "main"
  };
}
```

## Fluent Linking Style

**Do:** Embed links in text naturally

```markdown
The [parser module](https://github.com/.../parser.ts) handles
validation. See the [Schema class](https://github.com/...#L42-L60)
for the core logic.
```

**Don't:** Show raw URLs

```markdown
The parser module (https://github.com/foo/bar/blob/main/parser.ts)
handles validation.
```

## Default Branches

If ref not specified, assume:
- `main` (most repos)
- `master` (older repos)

Check `package.json` or repo settings if unsure.

## Linking Checklist

When mentioning code:
- [ ] Link to file when mentioning by name
- [ ] Include line numbers for specific code
- [ ] Use correct ref (branch/tag)
- [ ] Verify link resolves
