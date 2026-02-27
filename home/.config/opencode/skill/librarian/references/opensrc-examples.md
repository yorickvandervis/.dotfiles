# opensrc Code Examples

## Workflow: Fetch → Explore

### Basic Fetch and Explore with tree()

```javascript
async () => {
  const [{ source }] = await opensrc.fetch("vercel/ai");
  // Get directory structure first
  const tree = await opensrc.tree(source.name, { depth: 2 });
  return tree;
}
```

### Fetch and Read Key Files

```javascript
async () => {
  const [{ source }] = await opensrc.fetch("vercel/ai");
  const sourceName = source.name; // "github.com/vercel/ai"
  
  const files = await opensrc.readMany(sourceName, [
    "package.json",
    "README.md", 
    "src/index.ts"
  ]);
  
  return { sourceName, files };
}
```

### readMany with Globs

```javascript
async () => {
  const [{ source }] = await opensrc.fetch("zod");
  // Read all package.json files in monorepo
  const files = await opensrc.readMany(source.name, [
    "packages/*/package.json"  // globs supported!
  ]);
  return Object.keys(files);
}
```

### Batch Fetch Multiple Packages

```javascript
async () => {
  const results = await opensrc.fetch(["zod", "valibot", "yup"]);
  const names = results.map(r => r.source.name);
  
  // Compare how each handles string validation
  const comparisons = {};
  for (const name of names) {
    const matches = await opensrc.grep("string.*validate|validateString", { 
      sources: [name], 
      include: "*.ts",
      maxResults: 10 
    });
    comparisons[name] = matches.map(m => `${m.file}:${m.line}`);
  }
  return comparisons;
}
```

## Search Patterns

### Grep → Read Context

```javascript
async () => {
  const matches = await opensrc.grep("export function parse\\(", { 
    sources: ["zod"], 
    include: "*.ts" 
  });
  
  if (matches.length === 0) return "No matches";
  
  const match = matches[0];
  const content = await opensrc.read(match.source, match.file);
  const lines = content.split("\n");
  
  // Return 40 lines starting from match
  return {
    file: match.file,
    code: lines.slice(match.line - 1, match.line + 39).join("\n")
  };
}
```

### Search Across All Fetched Sources

```javascript
async () => {
  const sources = opensrc.list();
  const results = {};
  
  for (const source of sources) {
    const errorHandling = await opensrc.grep("throw new|catch \\(|\\.catch\\(", {
      sources: [source.name],
      include: "*.ts",
      maxResults: 20
    });
    results[source.name] = {
      type: source.type,
      errorPatterns: errorHandling.length
    };
  }
  
  return results;
}
```

## AST-Based Search

Use `astGrep` for semantic code search with pattern matching.

### Find Functions

```javascript
async () => {
  const matches = await opensrc.astGrep("zod", "function $NAME($$$ARGS)", { 
    glob: "**/*.ts", 
    limit: 10 
  });
  return matches.map(m => ({ 
    file: m.file, 
    name: m.metavars.NAME, 
    line: m.line 
  }));
}
```

### Find React Hooks

```javascript
async () => {
  const [{ source }] = await opensrc.fetch("vercel/ai");
  const hooks = await opensrc.astGrep(source.name, "use$HOOK($$$ARGS)", {
    glob: "**/*.tsx",
    limit: 50
  });
  return hooks.map(m => ({
    hook: `use${m.metavars.HOOK}`,
    file: m.file,
    line: m.line
  }));
}
```

### Find Exports

```javascript
async () => {
  const exports = await opensrc.astGrep("zod", "export { $$$NAMES }", {
    glob: "**/index.ts"
  });
  return exports;
}
```

## Common Workflows

### Understand a Library's Public API

```javascript
async () => {
  const [{ source }] = await opensrc.fetch("hono");
  
  // 1. Read entry point
  const pkg = await opensrc.read(source.name, "package.json");
  const { main, exports } = JSON.parse(pkg);
  
  // 2. Find all exports
  const exportMatches = await opensrc.astGrep(source.name, "export $$$", {
    glob: main || "src/index.ts"
  });
  
  return { entryPoint: main, exportCount: exportMatches.length };
}
```

### Compare Implementations

```javascript
async () => {
  await opensrc.fetch(["zod", "valibot"]);
  
  const comparison = {};
  for (const lib of ["zod", "valibot"]) {
    const stringImpl = await opensrc.grep("string\\(\\)", {
      sources: [lib],
      include: "*.ts",
      maxResults: 5
    });
    comparison[lib] = stringImpl.map(m => m.file);
  }
  
  return comparison;
}
```

### Find Entry Points

```javascript
async () => {
  const files = await opensrc.files("github.com/vercel/ai", "**/{index,main}.{ts,js}");
  if (files.length > 0) {
    return await opensrc.read("github.com/vercel/ai", files[0].path);
  }
  return "No entry point found";
}
```

## Cleanup

### Remove Sources

```javascript
async () => {
  return await opensrc.remove(["zod", "github.com/vercel/ai"]);
}
```

### Clean All

```javascript
async () => {
  return await opensrc.clean({ packages: true, repos: true });
}
```
