# Prevent chicken-egg problem with Homebrew and zim dependencies
#
if [ "$(uname)" = "Darwin" ]; then
    BREW_PREFIX="/opt/homebrew"
else
    BREW_PREFIX="/home/linuxbrew/.linuxbrew"
fi

export PATH="$BREW_PREFIX/bin:$PATH"

source $HOME/.zshrc.d/00-zim.zsh