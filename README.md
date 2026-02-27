# dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

Single `home/` package — mirrors `~` exactly. Stow creates symlinks from `~` into `~/.dotfiles/home/`.

## Configs

| Config | Path |
|--------|------|
| Fish shell | `~/.config/fish/` |
| Neovim (LazyVim) | `~/.config/nvim/` |
| OpenCode | `~/.config/opencode/` |
| Starship | `~/.config/starship.toml` |
| btop | `~/.config/btop/` |
| Ghostty | `~/.config/ghostty/` |
| Zellij | `~/.config/zellij/` |

---

## Fresh Install (macOS)

### 1. Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"  # Apple Silicon
```

### 2. Clone dotfiles

```bash
git clone https://github.com/yorickvandervis/.dotfiles.git ~/.dotfiles
```

### 3. Install tools

```bash
brew install stow fish fnm starship neovim btop zellij ghostty
brew install --cask font-jetbrains-mono-nerd-font

# Bun (JS runtime — required for opencode plugins)
curl -fsSL https://bun.sh/install | bash

# OpenCode (AI coding agent)
curl -fsSL https://opencode.ai/install | sh
```

### 4. Set fish as default shell

```bash
echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells
chsh -s /opt/homebrew/bin/fish
```

### 5. Handle conflicts

If any config dirs already exist as real directories (not symlinks), stow will refuse to overwrite them. Back them up or remove them first:

```bash
# Example: remove existing configs before stowing
rm -rf ~/.config/fish ~/.config/nvim ~/.config/btop ~/.config/ghostty ~/.config/zellij
# Keep ~/.config/starship.toml if you want to inspect it first, or just remove it:
rm -f ~/.config/starship.toml
```

> Note: `~/.config/opencode/` is special — opencode manages `node_modules/` inside it, so stow cannot create a top-level symlink. Instead stow creates individual symlinks for each file/dir inside the real `~/.config/opencode/`. This is expected behavior; no action needed.

### 6. Stow

```bash
stow --target="$HOME" home --dir ~/.dotfiles
```

### 7. Install Fisher + fish plugins

```bash
fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install < ~/.config/fish/fish_plugins"
```

### 8. Install opencode plugin dependencies

```bash
cd ~/.config/opencode && npm install && cd -
```

### 9. Open a new terminal

Fish is now the default shell. LazyVim bootstraps Neovim plugins on first launch of `nvim`.

---

## Fresh Install (Linux — Ubuntu/Debian)

### 1. Install core tools

```bash
sudo apt update && sudo apt install -y git curl stow

# Homebrew (recommended for consistent tooling)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
brew install fish fnm starship neovim btop zellij
```

### 2. Clone dotfiles

```bash
git clone https://github.com/yorickvandervis/.dotfiles.git ~/.dotfiles
```

### 3. Set fish as default shell

```bash
which fish | sudo tee -a /etc/shells
chsh -s $(which fish)
```

### 4–9. Follow macOS steps 5–9 above

---

## Updating an Existing Machine

```bash
cd ~/.dotfiles
git pull
stow -R --target="$HOME" home
fisher update
exec fish
```

---

## Adding a New Config

```bash
# 1. Move existing config into dotfiles
mv ~/.config/<name> ~/.dotfiles/home/.config/<name>

# 2. Restow (creates new symlinks)
stow -R --target="$HOME" home --dir ~/.dotfiles

# 3. Commit
cd ~/.dotfiles && git add home/.config/<name> && git commit -m "add <name> config"
```

---

## Fish Plugins

Managed via [Fisher](https://github.com/jorgebucaran/fisher) — declarative, file-based (`fish_plugins`):

- [jhillyerd/plugin-git](https://github.com/jhillyerd/plugin-git) — 100+ git abbreviations

Reinstall from scratch:
```bash
fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install < ~/.config/fish/fish_plugins"
```

---

## OpenCode Skills

| Skill | Description |
|-------|-------------|
| `feedback-loop` | Self-validate work through deterministic feedback loops |
| `spec-planner` | Dialogue-driven spec development |
| `cloudflare` | Cloudflare platform (Workers, D1, R2, DO, etc.) |
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
| [Fish](https://fishshell.com/) | `brew install fish` | shell |
| [Starship](https://starship.rs/) | `brew install starship` | prompt |
| [fnm](https://github.com/Schniz/fnm) | `brew install fnm` | Node version manager |
| [Neovim](https://neovim.io/) 0.11+ | `brew install neovim` | editor (LazyVim) |
| [Ghostty](https://ghostty.org/) | `brew install ghostty` | terminal |
| [Zellij](https://zellij.dev/) | `brew install zellij` | terminal multiplexer |
| [btop](https://github.com/aristocratos/btop) | `brew install btop` | system monitor |
| [Nerd Font](https://www.nerdfonts.com/) | `brew install --cask font-jetbrains-mono-nerd-font` | icons |
| [OpenCode](https://opencode.ai/) | `curl -fsSL https://opencode.ai/install \| sh` | AI coding agent |
| [Bun](https://bun.sh/) | `curl -fsSL https://bun.sh/install \| bash` | JS runtime + opencode plugins |
