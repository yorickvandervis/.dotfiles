---
name: agent-browser
description: Browser automation CLI for AI agents using Playwright
version: 1
---

# agent-browser

Browser automation CLI for AI agents. Use when tasks require web browsing, scraping, form filling, or web interaction. Built on Playwright with Rust CLI + Node.js daemon architecture.

## Installation

```bash
npm install -g agent-browser
agent-browser install  # Download Chromium
```

Linux: `agent-browser install --with-deps`

## Architecture

- **Rust CLI** (fast native binary) parses commands, communicates with daemon
- **Node.js daemon** manages Playwright browser instance, persists between commands
- Daemon auto-starts on first command, stays alive for fast subsequent ops
- Each session has own daemon process + Unix socket (or TCP on Windows)

## Core Workflow

1. **Open page**: `agent-browser open <url>`
2. **Get snapshot**: `agent-browser snapshot -i` (interactive elements only)
3. **Use refs**: `agent-browser click @e2` / `agent-browser fill @e3 "text"`
4. **Repeat snapshot** after page changes

## Refs (Primary Selection Method)

Snapshot generates ARIA accessibility tree with `[ref=eN]` tags. Refs map to `getByRole()` locators internally.

```bash
agent-browser snapshot
# - heading "Example Domain" [ref=e1] [level=1]
# - button "Submit" [ref=e2]
# - textbox "Email" [ref=e3]
# - link "Learn more" [ref=e4]

agent-browser click @e2           # Click button
agent-browser fill @e3 "test@example.com"
agent-browser get text @e1        # Get heading text
```

Ref syntax: `@e1`, `e1`, or `ref=e1` all work.

**Why refs?**
- Deterministic: points to exact element from snapshot
- Fast: no DOM re-query, uses cached role/name locator
- AI-friendly: snapshot + ref workflow optimal for LLMs

### Interactive Roles (get refs automatically)
`button`, `link`, `textbox`, `checkbox`, `radio`, `combobox`, `listbox`, `menuitem`, `option`, `searchbox`, `slider`, `spinbutton`, `switch`, `tab`, `treeitem`

### Content Roles (get refs when named)
`heading`, `cell`, `gridcell`, `columnheader`, `rowheader`, `listitem`, `article`, `region`, `main`, `navigation`

## Commands

### Navigation
```bash
agent-browser open <url>          # Auto-prepends https:// if needed
agent-browser back
agent-browser forward  
agent-browser reload
agent-browser close               # Closes browser + daemon
```

### Interaction
```bash
agent-browser click <sel>         # Left click
agent-browser dblclick <sel>      # Double click
agent-browser fill <sel> <text>   # Clear field + set value (atomic)
agent-browser type <sel> <text>   # Type character by character (preserves existing)
agent-browser press <key>         # Key press: Enter, Tab, Control+a, Shift+Tab
agent-browser hover <sel>
agent-browser focus <sel>
agent-browser select <sel> <val>  # Select dropdown option by value
agent-browser check <sel>         # Check checkbox
agent-browser uncheck <sel>       # Uncheck checkbox
agent-browser scroll up|down|left|right [px]  # Default 300px
agent-browser drag <src> <tgt>    # Drag and drop
agent-browser upload <sel> <file1> [file2...]
```

### Get Info
```bash
agent-browser get text <sel>      # textContent
agent-browser get html <sel>      # innerHTML
agent-browser get value <sel>     # input value
agent-browser get attr <sel> <attr>
agent-browser get title
agent-browser get url
agent-browser get count <sel>     # Number of matching elements
```

### Snapshot Options
```bash
agent-browser snapshot            # Full accessibility tree
agent-browser snapshot -i         # Interactive elements only (buttons, inputs, links)
agent-browser snapshot -c         # Compact (remove empty structural elements)
agent-browser snapshot -d 3       # Limit depth to 3 levels
agent-browser snapshot -s "#main" # Scope to CSS selector
agent-browser snapshot -i -c -d 5 # Combine options
```

### Wait
```bash
agent-browser wait <selector>     # Wait for element visible
agent-browser wait <ms>           # Wait for time (numeric = milliseconds)
agent-browser wait --text "Welcome"
agent-browser wait --url "**/dashboard"
agent-browser wait --load networkidle  # load | domcontentloaded | networkidle
```

### Sessions (Isolated Browser Instances)
```bash
agent-browser --session agent1 open site-a.com
agent-browser --session agent2 open site-b.com
agent-browser session list        # List active sessions
```

## Patterns

### Login Flow
```bash
agent-browser open https://example.com/login
agent-browser snapshot -i
agent-browser fill @e2 "username"
agent-browser fill @e3 "password"
agent-browser click @e4
agent-browser wait --url "**/dashboard"
agent-browser state save auth.json  # Persist auth for later
```

### Form Submission
```bash
agent-browser open https://example.com/form
agent-browser snapshot -i --json
agent-browser fill @e1 "John Doe"
agent-browser fill @e2 "john@example.com"
agent-browser select @e3 "option-value"
agent-browser check @e4
agent-browser click @e5
agent-browser wait --text "Success"
```

## Anti-Patterns

- **Don't use CSS selectors when refs available** - refs from snapshot are deterministic
- **Don't skip snapshot after page changes** - refs become stale after navigation
- **Don't use `type` when `fill` works** - `fill` atomically clears + sets, `type` appends
- **Don't hardcode wait times** - use semantic waits (`--text`, `--url`, `--load`)
