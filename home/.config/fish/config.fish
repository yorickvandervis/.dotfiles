# Disable greeting
set fish_greeting

# Auto-start zellij (skip if already inside a session)
if status is-interactive && test -z "$ZELLIJ"
    zellij
end

# Editor
set -gx EDITOR nvim
set -gx MANPAGER 'nvim +Man!'

# pnpm
set -gx PNPM_HOME "/Users/pf57ma/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
