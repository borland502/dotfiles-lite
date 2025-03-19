ZDOTDIR=$HOME/.config/zsh
ZIM_HOME="${XDG_DATA_HOME}/zim"

export XDG_CACHE_HOME=${XDG_CACHE_HOME:-"$HOME"/.cache}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-"$HOME"/.config}
export XDG_DATA_HOME=${XDG_DATA_HOME:-"$HOME"/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-"$HOME"/.local/state}
export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-"$TMPDIR"}
export XDG_LIB_HOME=${XDG_LIB_HOME:-"$HOME"/.local/lib}
export XDG_BIN_HOME=${XDG_BIN_HOME:-"$HOME"/.local/bin}

if ! [ -d "${XDG_CACHE_HOME}" ]; then
  mkdir -p "${XDG_CACHE_HOME}"
fi

if ! [ -d "${XDG_CONFIG_HOME}" ]; then
  mkdir -p "${XDG_CONFIG_HOME}"
fi

if ! [ -d "${XDG_DATA_HOME}" ]; then
  mkdir -p "${XDG_DATA_HOME}"
fi

if ! [ -d "${XDG_STATE_HOME}" ]; then
  mkdir -p "${XDG_STATE_HOME}"
fi

if ! [ -d "${XDG_RUNTIME_DIR}" ]; then
  mkdir -p "${XDG_RUNTIME_DIR}"
fi

if [ "$(/usr/bin/uname)" = "Darwin" ]; then
  # macOS: prefer the default Homebrew installation paths
  if [ -d "/opt/homebrew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -d "/usr/local/Homebrew" ]; then
    eval "$(/usr/local/Homebrew/bin/brew shellenv)"
  fi
elif [ "$(/usr/bin/uname)" = "Linux" ]; then
  # Linux: set up Linuxbrew
  if [ -d "/home/linuxbrew/.linuxbrew" ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  elif [ -d "/home/linuxbrew/.brew" ]; then
    eval "$(/home/linuxbrew/.brew/bin/brew shellenv)"
  fi
fi