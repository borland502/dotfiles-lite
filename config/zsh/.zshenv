ZDOTDIR=$HOME/.config/zsh

#
# XDG Specification
#
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-"$HOME"/.cache}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-"$HOME"/.config}
export XDG_DATA_HOME=${XDG_DATA_HOME:-"$HOME"/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-"$HOME"/.local/state}
export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-"$TMPDIR"}

# Default Apps
export EDITOR="vim"
export VISUAL="code -n"
export TERMINAL="kitty"
export BROWSER="vivaldi"
export PAGER="less"

if [[ "$(/usr/bin/uname)" == "Darwin" ]]; then
  # macOS: prefer the default Homebrew installation paths
  if [ -d /opt/homebrew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -d /usr/local/Homebrew ]; then
    eval "$(/usr/local/Homebrew/bin/brew shellenv)"
  fi
elif [[ "$(/usr/bin/uname)" == "Linux" ]]; then
  # Linux: set up Linuxbrew
  if [ -d /home/linuxbrew/.linuxbrew ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  elif [ -d /home/linuxbrew/.brew ]; then
    eval "$(/home/linuxbrew/.brew/bin/brew shellenv)"
  fi
fi
