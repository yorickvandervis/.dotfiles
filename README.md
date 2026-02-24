# dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Packages

| Package | What | Target |
|---------|------|--------|
| `opencode` | OpenCode AI agent config (agents, skills, commands, plugins, MCP servers) | `~/.config/opencode/` |
| `nvim` | Neovim config (LazyVim) | `~/.config/nvim/` |
| `btop` | btop system monitor config + themes | `~/.config/btop/` |
| `zsh` | Zsh config + plugins (autosuggestions, syntax highlighting) | `~/.zshrc`, `~/.zsh/` |

## Setup on a New Machine

```bash
# 1. Clone (repo name is .dotfiles, so it lands in ~/.dotfiles automatically)
git clone --recursive https://github.com/yorickvandervis/.dotfiles.git ~

# 2. Install stow
sudo apt install stow    # Ubuntu/Debian
# brew install stow      # macOS

# 3. Stow all packages
cd ~/.dotfiles
stow -t ~ opencode nvim btop zsh

# 4. Install opencode dependencies
cd ~/.config/opencode && npm install && cd -

# 5. Install cloudflare skill (optional)
curl -fsSL https://raw.githubusercontent.com/dmmulroy/cloudflare-skill/main/install.sh | bash -s -- --global
```

## Stow Commands

```bash
# Stow a single package (create symlinks)
stow -d ~/.dotfiles -t ~ <package>

# Restow (refresh symlinks after changes)
stow -R -d ~/.dotfiles -t ~ <package>

# Unstow (remove symlinks)
stow -D -d ~/.dotfiles -t ~ <package>

# Stow all packages
cd ~/.dotfiles && stow -t ~ opencode nvim btop zsh
```

## Adding a New Package

```bash
# 1. Create the stow-compatible directory structure
mkdir -p ~/.dotfiles/<name>/.config/<name>

# 2. Move existing config
mv ~/.config/<name>/* ~/.dotfiles/<name>/.config/<name>/

# 3. Stow it
stow -d ~/.dotfiles -t ~ <name>

# 4. Commit
cd ~/.dotfiles && git add <name> && git commit -m "add <name> config"
```

## OpenCode Skills

| Skill | Description |
|-------|-------------|
| `feedback-loop` | Self-validate work through deterministic feedback loops |
| `spec-planner` | Dialogue-driven spec development through skeptical questioning |
| `cloudflare` | Cloudflare platform docs (Workers, D1, R2, DO, etc.) |
| `build-skill` | Create OpenCode skills |
| `librarian` | Multi-repo codebase exploration |
| `index-knowledge` | Generate AGENTS.md knowledge bases |
| `prd` / `prd-task` | Product requirements documents |
| `frontend-design` | Production-grade frontend interfaces |
| `agent-browser` | Browser automation via Playwright |
| `session-export` | Export session summaries to PRs |
| `vcs-detect` | Detect version control system |

## Zsh Plugins

Managed as git submodules:

- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) -- fish-like autosuggestions
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) -- fish-like syntax highlighting

After cloning, run `git submodule update --init --recursive` if you didn't use `--recursive`.

## Dependencies

- [GNU Stow](https://www.gnu.org/software/stow/) -- symlink farm manager
- [Starship](https://starship.rs/) -- cross-shell prompt
- [Neovim](https://neovim.io/) 0.11+ -- editor
- [OpenCode](https://opencode.ai/) -- AI coding agent
- [Bun](https://bun.sh/) / Node.js -- for opencode plugins
