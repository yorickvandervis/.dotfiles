# fnm — fast Node version manager with .nvmrc auto-switch
# Replaces nvm + the lazy-load boilerplate in .zshrc
if command -q fnm
    fnm env --use-on-cd --log-level=quiet | source
end
