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
path=(
  "$HOME/.local/bin"
  "$HOME/.opencode/bin"
  "$HOME/.bun/bin"
  "$HOME/.fly/bin"
  "/snap/bin"
  $path
)

# -- Prompt --
eval "$(starship init zsh)"

# -- NVM (lazy-loaded) --
export NVM_DIR="$HOME/.nvm"
nvm() {
  unfunction nvm node npm npx 2>/dev/null
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  nvm "$@"
}
node() { nvm --version >/dev/null 2>&1; unfunction node 2>/dev/null; node "$@"; }
npm()  { nvm --version >/dev/null 2>&1; unfunction npm 2>/dev/null; npm "$@"; }
npx()  { nvm --version >/dev/null 2>&1; unfunction npx 2>/dev/null; npx "$@"; }

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
