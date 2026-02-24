# -- History --
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS

# -- Options --
setopt AUTO_CD
setopt INTERACTIVE_COMMENTS

# -- Completion --
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# -- PATH --
typeset -U path
export PNPM_HOME="$HOME/.local/share/pnpm"
path=(
  "$HOME/.local/bin"
  "$HOME/.opencode/bin"
  "$HOME/.bun/bin"
  "$HOME/.fly/bin"
  "$PNPM_HOME"
  "/snap/bin"
  $path
)

# -- Prompt --
eval "$(starship init zsh)"

# -- NVM (lazy-loaded, auto-switches on .nvmrc) --
export NVM_DIR="$HOME/.nvm"
_nvm_load() {
  unfunction nvm node npm npx _nvm_load 2>/dev/null
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
}
nvm()  { _nvm_load; nvm "$@"; }
node() { _nvm_load; node "$@"; }
npm()  { _nvm_load; npm "$@"; }
npx()  { _nvm_load; npx "$@"; }

# Auto-switch node version when entering a directory with .nvmrc
_nvm_auto_use() {
  if [ -f .nvmrc ]; then
    # Ensure nvm is loaded
    if ! command -v nvm &>/dev/null || [ "$(type -w nvm)" = "nvm: function" ] && [ "$(which nvm 2>/dev/null)" = "" ]; then
      _nvm_load 2>/dev/null
    fi
    local target
    target="$(cat .nvmrc)"
    local current
    current="$(node --version 2>/dev/null)"
    # Only switch if needed (avoids slow nvm use on every cd)
    if [ "$current" != "v${target#v}" ]; then
      nvm use --silent 2>/dev/null
    fi
  fi
}
autoload -U add-zsh-hook
add-zsh-hook chpwd _nvm_auto_use

# -- Bun --
export BUN_INSTALL="$HOME/.bun"
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"

# -- Plugins --
ZSH_PLUGINS="$HOME/.zsh/plugins"
[ -d "$ZSH_PLUGINS/zsh-autosuggestions" ] && \
  source "$ZSH_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh"
[ -d "$ZSH_PLUGINS/zsh-syntax-highlighting" ] && \
  source "$ZSH_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# -- Aliases --
alias v="nvim"
alias g="git"
alias gs="git status"
alias gl="git log --oneline -20"
alias gd="git diff"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias oc="opencode"
alias ll="ls -lah"
alias la="ls -la"

