#!/usr/bin/env bash

# Install the dependencies
if ! [[ $(command -v brew) ]]; then
  echo "Installing Homebrew"
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

test "$(command -v brew)" || exit 2

if ! [[ $(command -v gum) ]]; then
  echo "Installing Gum"
  brew install gum
fi

if ! [[ $(command -v task) ]]; then
  echo "Installing Taskfiles.dev"
  brew install go-task
fi

# shellcheck disable=SC1091
source "./lib/logging.sh"

info "Installing helper scripts for $SHELL"
task