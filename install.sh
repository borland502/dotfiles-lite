#!/usr/bin/env bash

PATH="$HOME/.local/bin:/home/linuxbrew/.linuxbrew/bin:/opt/linuxbrew/bin:$PATH"

# Install the dependencies

# hard link the .zshrc file
ln -f "config/zsh/.zshrc" "$HOME/.zshrc"

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
cp -Ral ./config/zsh/.zshrc.d/ ~/.zshrc.d/ 2> /dev/null

if ! [[ $(command -v task) ]]; then
  echo "Installing Taskfiles.dev"
  brew install go-task
fi

test "$(command -v task)" || exit 2

# shellcheck disable=SC1091
source "./lib/logging.sh"

task install:all