# dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Packages

| Package | What | Target |
|---------|------|--------|
| `fish` | Fish shell config (conf.d, functions, completions) | `~/.config/fish/` |
| `nvim` | Neovim config (LazyVim) | `~/.config/nvim/` |
| `opencode` | OpenCode AI agent config (agents, skills, commands, plugins, MCP servers) | `~/.config/opencode/` |
| `btop` | btop system monitor config + themes | `~/.config/btop/` |
| `zsh` | Zsh config (fallback) | `~/.zshrc`, `~/.zsh/` |

## Setup on a New Machine (macOS)

### 1. Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# Apple Silicon — add brew to PATH for this session so next steps work
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### 2. Clone dotfiles

```bash
git clone --recursive https://github.com/yorickvandervis/.dotfiles.git ~/.dotfiles
```

### 3. Install tools

```bash
brew install stow fish fnm starship neovim btop

# Install Bun
curl -fsSL https://bun.sh/install | bash

# Install opencode
curl -fsSL https://opencode.ai/install | sh
```

### 4. Set fish as default shell

```bash
echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells
chsh -s /opt/homebrew/bin/fish
```

### 5. Stow packages

```bash
cd ~/.dotfiles
stow -t ~ fish nvim opencode btop
```

### 6. Install Fisher + fish plugins

```bash
fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install < ~/.config/fish/fish_plugins"
```

### 7. Generate bun completions

```bash
bun completions fish > ~/.dotfiles/fish/.config/fish/completions/bun.fish
```

### 8. Install opencode plugin dependencies

```bash
cd ~/.config/opencode && npm install && cd -
```

### 9. Install a Nerd Font

Required by LazyVim for icons/glyphs:

```bash
brew install --cask font-jetbrains-mono-nerd-font
```

### 10. Open a new terminal

Fish is now the default shell. LazyVim will bootstrap Neovim plugins on first launch of `nvim`.

---

## Setup on a New Machine (Linux — Ubuntu/Debian)

### 1. Install core tools

```bash
sudo apt update && sudo apt install -y git curl stow

# Homebrew (optional but recommended for consistent tooling)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
brew install fish fnm starship neovim btop
```

### 2. Clone dotfiles

```bash
git clone --recursive https://github.com/yorickvandervis/.dotfiles.git ~/.dotfiles
```

### 3. Set fish as default shell

```bash
which fish | sudo tee -a /etc/shells
chsh -s $(which fish)
```

### 4–10. Follow macOS steps 5–10 above

---

## Updating an Existing Machine

```bash
cd ~/.dotfiles

# 1. Pull latest
git pull --recurse-submodules

# 2. Restow (refreshes symlinks)
stow -R -t ~ fish nvim opencode btop

# 3. Update fish plugins
fisher update

# 4. Reload
exec fish
```

---

## Stow Commands

```bash
# Stow a single package
stow -d ~/.dotfiles -t ~ <package>

# Restow (refresh symlinks after changes)
stow -R -d ~/.dotfiles -t ~ <package>

# Unstow (remove symlinks)
stow -D -d ~/.dotfiles -t ~ <package>

# Stow all packages
cd ~/.dotfiles && stow -t ~ fish nvim opencode btop
```

## Adding a New Package

```bash
# 1. Create stow-compatible structure
mkdir -p ~/.dotfiles/<name>/.config/<name>

# 2. Move existing config
mv ~/.config/<name>/* ~/.dotfiles/<name>/.config/<name>/

# 3. Stow it
stow -d ~/.dotfiles -t ~ <name>

# 4. Commit
cd ~/.dotfiles && git add <name> && git commit -m "add <name> config"
```

---

## Fish Plugins

Managed via [Fisher](https://github.com/jorgebucaran/fisher) — declarative, file-based (`fish_plugins`):

- [jhillyerd/plugin-git](https://github.com/jhillyerd/plugin-git) -- 100+ git abbreviations (ported from oh-my-zsh)

To reinstall from scratch:
```bash
fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install < ~/.config/fish/fish_plugins"
```

---

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
| `agent-browser` | Browser automation via Playwright |
| `session-export` | Export session summaries to PRs |
| `vcs-detect` | Detect version control system |

---

## Dependencies

| Tool | Install | Purpose |
|------|---------|---------|
| [GNU Stow](https://www.gnu.org/software/stow/) | `brew install stow` | symlink farm manager |
| [Fish](https://fishshell.com/) | `brew install fish` | primary shell |
| [Starship](https://starship.rs/) | `brew install starship` | prompt |
| [fnm](https://github.com/Schniz/fnm) | `brew install fnm` | Node version manager |
| [Neovim](https://neovim.io/) 0.11+ | `brew install neovim` | editor (LazyVim) |
| [Nerd Font](https://www.nerdfonts.com/) | `brew install --cask font-jetbrains-mono-nerd-font` | icons for LazyVim |
| [OpenCode](https://opencode.ai/) | `curl -fsSL https://opencode.ai/install \| sh` | AI coding agent |
| [Bun](https://bun.sh/) | `curl -fsSL https://bun.sh/install \| bash` | JS runtime + opencode plugins |
| [btop](https://github.com/aristocratos/btop) | `brew install btop` | system monitor |
