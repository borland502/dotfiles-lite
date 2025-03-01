#!/usr/bin/env bash
# Color definitions (Monokai Pro Filter Spectrum)
INFO_COLOR="#FC9867"   # Orange
DEBUG_COLOR="#78DCE8"  # Blue
WARN_COLOR="#FFD866"   # Yellow
ERROR_COLOR="#FF6188"  # Red# Logging utility using gum with Monokai Pro Filter Spectrum colors

# shellcheck disable=SC1091
source "lib/colors.sh"

function info() {
    gum log --level=info --time=RFC850 --format=false \
    --level.foreground="$INFO_COLOR" "$*"
}

function debug() {
    gum log --level debug --time=RFC850 --format=true \
    --level.foreground "$DEBUG_COLOR" "$*"
}

function warn() {
    gum log --level warn --time=RFC850 --format=true \
    --level.foreground "$WARN_COLOR" "$*"
}

function error() {
    gum log --level error --time=RFC850 --format=true \
    --level.foreground "$ERROR_COLOR" "$*"
}

function log() {
    case "$1" in
        info)
            shift
            info "$*"
        ;;
        debug)
            shift
            debug "$*"
        ;;
        warn)
            shift
            warn "$*"
        ;;
        error)
            shift
            error "$*"
        ;;
        *)
            error "Unknown log level: $1"
            return 1
        ;;
    esac
}

function help() {
    info "This is an info message"
    debug "This is a debug message"
    warn "This is a warning message"
    error "This is an error message"
}
export PATH="$HOME/.local/bin:/home/linuxbrew/.linuxbrew/bin:/opt/linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:/opt/linuxbrew/sbin:$PATH"



## Rootless - standard shell is used here rather than gum to avoid issues
if [[ "$USER" == "root" ]]; then
    echo "This script must be run as a non-root user. Please enter new user details:"
    read -p "Username: " newuser
    read -p "Password: " newpass
    
    useradd -m -s /bin/bash "$newuser"
    echo "$newuser:$newpass" | chpasswd
    usermod -aG sudo "$newuser"
    echo "$newuser ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
    
    script_dir="/home/$newuser/$(dirname "$(dirname "$0")")"
    mkdir -p "$script_dir"
    rsync -a "$(dirname "$(dirname "$0")")/" "$script_dir/"
    chown -R "$newuser:$newuser" "/home/$newuser"
    
    # if home brew is already installed, change the owner of the directory
    if [[ -d "/home/linuxbrew/.linuxbrew" ]]; then
        chown -R "$newuser:$newuser" "/home/linuxbrew/.linuxbrew"
    fi
    
    echo "Restarting script as $newuser"
    cd "$script_dir"
    exec su - "$newuser" -c "zsh $(basename $0)"
fi

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
