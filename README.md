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
cd ~/.config/opencode && bun install && cd -
```

### 9. Open a new terminal

Fish is now the default shell. LazyVim bootstraps Neovim plugins on first launch of `nvim`.

---

## Fresh Install (Linux — Ubuntu/Debian)

> **WSL2 note:** If running under WSL2, install Ghostty and the Nerd Font on the **Windows** side — your Windows terminal emulator renders the fonts, not WSL. Skip those steps below.

### 1. Clone dotfiles

```bash
sudo apt update && sudo apt install -y git
git clone https://github.com/yorickvandervis/.dotfiles.git ~/.dotfiles
```

### 2. Install tools

Pick **Option A** (Homebrew) or **Option B** (apt + install scripts).

#### Option A: Homebrew (matches macOS)

Gives you the same versions and commands as macOS. Uses more disk (~1–2 GB for Brew's toolchain).

```bash
sudo apt install -y curl stow build-essential

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Install tools
brew install fish fnm starship neovim btop zellij
```

#### Option B: apt + install scripts (no Homebrew)

Lighter footprint. Uses apt where possible and individual install scripts for tools apt doesn't carry or has outdated versions of.

```bash
sudo apt install -y curl stow fish btop

# Neovim (PPA for 0.11+ — required by LazyVim)
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt install -y neovim

# Starship
curl -sS https://starship.rs/install.sh | sh

# fnm
curl -fsSL https://fnm.vercel.app/install | bash

# Zellij (download latest binary)
curl -L "https://github.com/zellij-org/zellij/releases/latest/download/zellij-x86_64-unknown-linux-musl.tar.gz" | tar -xz
sudo mv zellij /usr/local/bin/
```

### 3. Install Bun + OpenCode

Same for both options:

```bash
# Bun (JS runtime — required for opencode plugins)
curl -fsSL https://bun.sh/install | bash

# OpenCode (AI coding agent)
curl -fsSL https://opencode.ai/install | sh
```

### 4. Set fish as default shell

```bash
which fish | sudo tee -a /etc/shells
chsh -s $(which fish)
```

### 5. Handle conflicts

Back up or remove existing configs that would conflict with stow:

```bash
rm -rf ~/.config/fish ~/.config/nvim ~/.config/btop ~/.config/zellij
rm -f ~/.config/starship.toml
```

> On a fresh Linux install these likely don't exist yet. On WSL2, skip `~/.config/ghostty/` — it's not used on the Linux side.

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
cd ~/.config/opencode && bun install && cd -
```

### 9. Open a new terminal

Fish is now the default shell. LazyVim bootstraps Neovim plugins on first launch of `nvim`.

---

## WSL2 Tips

- **Ghostty** — Install on Windows, not inside WSL. It's your terminal emulator and runs natively on the host.
- **Nerd Font** — Install [JetBrains Mono Nerd Font](https://www.nerdfonts.com/) on Windows and set it in your terminal (Ghostty / Windows Terminal). WSL inherits the font from the host terminal.
- **Clipboard** — Fish/Neovim clipboard integration with Windows works out of the box on recent WSL2 builds via `win32yank` or the built-in `/mnt/c/Windows/System32/clip.exe`.

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

| Tool | macOS | Linux (Brew) | Linux (apt/script) | Purpose |
|------|-------|-------------|-------------------|---------|
| [GNU Stow](https://www.gnu.org/software/stow/) | `brew install stow` | `brew install stow` | `apt install stow` | symlink farm manager |
| [Fish](https://fishshell.com/) | `brew install fish` | `brew install fish` | `apt install fish` | shell |
| [Starship](https://starship.rs/) | `brew install starship` | `brew install starship` | [install script](https://starship.rs/guide/#step-1-install-starship) | prompt |
| [fnm](https://github.com/Schniz/fnm) | `brew install fnm` | `brew install fnm` | [install script](https://github.com/Schniz/fnm#install) | Node version manager |
| [Neovim](https://neovim.io/) 0.11+ | `brew install neovim` | `brew install neovim` | PPA `neovim-ppa/unstable` | editor (LazyVim) |
| [Ghostty](https://ghostty.org/) | `brew install ghostty` | — | — (Windows side on WSL2) | terminal |
| [Zellij](https://zellij.dev/) | `brew install zellij` | `brew install zellij` | [GitHub releases](https://github.com/zellij-org/zellij/releases) | terminal multiplexer |
| [btop](https://github.com/aristocratos/btop) | `brew install btop` | `brew install btop` | `apt install btop` | system monitor |
| [Nerd Font](https://www.nerdfonts.com/) | `brew install --cask font-jetbrains-mono-nerd-font` | — | — (Windows side on WSL2) | icons |
| [OpenCode](https://opencode.ai/) | `curl -fsSL https://opencode.ai/install \| sh` | `curl -fsSL https://opencode.ai/install \| sh` | `curl -fsSL https://opencode.ai/install \| sh` | AI coding agent |
| [Bun](https://bun.sh/) | `curl -fsSL https://bun.sh/install \| bash` | `curl -fsSL https://bun.sh/install \| bash` | `curl -fsSL https://bun.sh/install \| bash` | JS runtime + opencode plugins |
