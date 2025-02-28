source $HOME/.zshrc.d/00-znap.zsh

if [ "$(uname)" = "Darwin" ]; then
    BREW_PREFIX="/opt/homebrew"
else
    BREW_PREFIX="/home/linuxbrew/.linuxbrew"
fi
export PATH="$BREW_PREFIX/bin:$PATH"
znap eval brew '$BREW_PREFIX/bin/brew shellenv'

source $HOME/.zshrc.d/01-sensible-default.zsh
source $HOME/.zshrc.d/02-aliases.zsh
source $HOME/.zshrc.d/03-completions.zsh
source $HOME/.zshrc.d/04-exports.zsh
source $HOME/.zshrc.d/05-plugins.zsh

znap eval zoxide "zoxide init zsh" 2> /dev/null
znap eval atuin "atuin init zsh" 2> /dev/null
znap eval fzf "fzf --zsh" 2> /dev/null
znap eval starship 'starship init zsh --print-full-init'
