# Disable greeting
set fish_greeting

# Auto-start zellij (skip if already inside a session)
if status is-interactive && test -z "$ZELLIJ"
    zellij
end

# Editor
set -gx EDITOR nvim
set -gx MANPAGER 'nvim +Man!'
