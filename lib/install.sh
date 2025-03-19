#!/usr/bin/env bash
# shellcheck disable=SC2148

mkdir -p "${XDG_CONFIG_HOME}/zsh"
mkdir -p "${XDG_DATA_HOME}"

backup_file="${HOME}/.zshenv.backup.$(date +%Y%m%d%H%M%S)"
echo "Backing up ~/.zshenv to ${backup_file}"
mv "${HOME}/.zshenv" "${backup_file}"

rsync -avzPh ./config/* "${XDG_CONFIG_HOME}"

backup_file="${HOME}/.envrc.backup.$(date +%Y%m%d%H%M%S)"
echo "Backing up ~/.envrc to ${backup_file}"
mv "${HOME}/.envrc" "${backup_file}"

cp .envrc "${HOME}/.envrc"

PATH="$HOME/.local/bin:/home/linuxbrew/.linuxbrew/bin:/opt/homebrew/bin:/home/linuxbrew/.linuxbrew/sbin:/opt/homebrew/sbin:$PATH"

if ! [[ $(command -v rsync) ]]; then
    echo "Please install rsync with your package manager"
fi

if ! [[ $(command -v zsh) ]] && [[ "$USER" != "root" ]]; then
    echo "Please install zsh with your package manager"
    exit 1
fi

## Rootless - standard shell is used here rather than gum to avoid issues
if [[ "$USER" == "root" ]]; then
    echo "This script must be run as a non-root user. Please enter new user details:"
    read -p "Username: " newuser
    read -sp "Password: " newpass
    
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
    cd "$script_dir" || exit
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
cp "./config/zsh/.zshrc" "${XDG_CONFIG_HOME}/zsh/zshrc"

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


if ! [[ $(command -v task) ]]; then
    echo "Installing Taskfiles.dev"
    brew install go-task
fi

test "$(command -v task)" || exit 2

if ! [ $(command -v direnv) ]; then
    echo "Installing direnv"
    brew install direnv
fi

test "$(command -v direnv)" || exit 2

task install:all

. ~/.config/zsh/zshrc
