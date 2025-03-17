#!/usr/bin/env bash
# Color definitions (Monokai Pro Filter Spectrum)
INFO_COLOR="#FC9867"   # Orange
DEBUG_COLOR="#78DCE8"  # Blue
WARN_COLOR="#FFD866"   # Yellow
ERROR_COLOR="#FF6188"  # Red# Logging utility using gum with Monokai Pro Filter Spectrum colors

# cult of the xdg base directory
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:=$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:=$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:=$HOME/.cache}"
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:=$HOME/.local/run/user/$(id -u)}"
export XDG_STATE_HOME="${XDG_STATE_HOME:=$HOME/.local/state}"

# Create the directories
for path in "$XDG_CONFIG_HOME" "$XDG_DATA_HOME" "$XDG_CACHE_HOME" "$XDG_RUNTIME_DIR" "$XDG_STATE_HOME"; do
  mkdir -p "$path"
done

# cult of the xdg base directory
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:=$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:=$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:=$HOME/.cache}"
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:=$HOME/.local/run/user/$(id -u)}"
export XDG_STATE_HOME="${XDG_STATE_HOME:=$HOME/.local/state}"

# Create the directories
for path in "$XDG_CONFIG_HOME" "$XDG_DATA_HOME" "$XDG_CACHE_HOME" "$XDG_RUNTIME_DIR" "$XDG_STATE_HOME"; do
  mkdir -p "$path"
done

PATH="$HOME/.local/bin:/home/linuxbrew/.linuxbrew/bin:/opt/linuxbrew/bin:$PATH"

# Install the dependencies
rsync -u "config/zsh/.zshrc" "$HOME/"
rsync -u "config/zsh/.zimrc" "$HOME/"

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

rsync -u "config/zsh/.zshrc" "$HOME/.zshrc"

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
rsync -u ./config/zsh/.zshrc.d/* ~/.zshrc.d/

if ! [[ $(command -v task) ]]; then
    echo "Installing Taskfiles.dev"
    brew install go-task
fi

test "$(command -v task)" || exit 2

# shellcheck disable=SC1091
source "./lib/logging.sh"

task install:all
task setup:starship
task setup:fzf
