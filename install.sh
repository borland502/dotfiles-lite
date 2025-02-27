#!/usr/bin/env bash

PATH="$HOME/.local/bin:/home/linuxbrew/.linuxbrew/bin:/opt/linuxbrew/bin:$PATH"

# Install the dependencies
## Homebrew
if ! [[ $(command -v brew) ]]; then
  echo "Installing Homebrew"
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ "$OSTYPE" == "linux"* ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

if [ "$(uname)" = "Darwin" ]; then
  BREW_PREFIX="/opt/homebrew"
else
  BREW_PREFIX="/home/linuxbrew/.linuxbrew"
fi
echo "export PATH=\"$BREW_PREFIX/bin:\$PATH\"" >> $HOME/.zshrc
echo "eval \"\$($BREW_PREFIX/bin/brew shellenv)\"" >> $HOME/.zshrc
eval "$($BREW_PREFIX/bin/brew shellenv)"

test "$(command -v brew)" || exit 2

## Zsh
if [[ "${SHELL}" != *"zsh" ]]; then
  if [[ $(command -v zsh) ]]; then
    echo "Zsh is not your default shell, but it is installed. Please run 'chsh -s $(which zsh)' to make it your default shell."  
  else
    echo "Zsh is not installed. Please install it at the system level or add this userspace shell in /etc/shells"
    brew install zsh
  fi

  # placeholder for restart
  echo "export SHELL=$(which zsh)" > $HOME/.zshenv
  exec zsh -- "$0" "$@"
fi

## Znap - https://github.com/marlonrichert/zsh-snap
# Download Znap, if it's not there yet.
[[ -r ~/Development/github/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/Development/github/znap
source ~/Development/github/znap/znap.zsh  # Start Znap

## Gum
if ! [[ $(command -v gum) ]]; then
  echo "Installing Gum"
  brew install gum
fi

test "$(command -v gum)" || exit 2

## Gomplate
if ! [[ $(command -v gomplate) ]]; then
  echo "Installing Gomplate"
  brew install gomplate
fi

test "$(command -v gomplate)" || exit 2

gomplate -f config/.env.tmpl -o .env

if ! [[ $(command -v task) ]]; then
  echo "Installing Taskfiles.dev"
  brew install go-task
fi

test "$(command -v task)" || exit 2

# shellcheck disable=SC1091
source "./lib/logging.sh"

task install:all