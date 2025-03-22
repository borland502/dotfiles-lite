export STARSHIP_CONFIG=~/.config/starship/starship.toml

if "$(command -v dircolors)"; then
    eval "$(dircolors -b ${XDG_CONFIG_HOME}/colors/dircolors.monokai 2>/dev/null)"
fi