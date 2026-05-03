# fnm — fast Node version manager with .nvmrc auto-switch
set -gx FNM_PATH "$HOME/.local/share/fnm"
if test -d $FNM_PATH
    fish_add_path $FNM_PATH
    fnm env --use-on-cd --log-level=quiet | source
end
