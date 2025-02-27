#!/usr/bin/env bash

PATH="$HOME/.local/bin:/home/linuxbrew/.linuxbrew/bin:/opt/linuxbrew/bin:$PATH"

# Install the dependencies
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

if ! [[ $(command -v gum) ]]; then
  echo "Installing Gum"
  brew install gum
fi

test "$(command -v gum)" || exit 2

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