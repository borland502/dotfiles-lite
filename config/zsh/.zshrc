source ${XDG_CONFIG_HOME}/.zshrc.d/00-zim.zsh

if [ "$(uname)" = "Darwin" ]; then
    BREW_PREFIX="/opt/homebrew"
else
    BREW_PREFIX="/home/linuxbrew/.linuxbrew"
fi
export PATH="$BREW_PREFIX/bin:$PATH"
