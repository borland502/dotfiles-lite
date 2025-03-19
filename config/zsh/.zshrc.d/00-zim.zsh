# Zim
ZIM_CONFIG_FILE=${ZDOTDIR}/.zimrc
ZIM_HOME=${XDG_DATA_HOME}/zim
mkdir -p ${ZIM_HOME}

# Download zimfw plugin manager if missing.
if [ ! -e ${ZIM_HOME}/zimfw.zsh ]; then
  curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

# Install missing modules and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE} ]; then
  zsh -c ". ${ZIM_HOME}/zimfw.zsh init"
fi

# Initialize modules.
zsh -c ". ${ZIM_HOME}/init.zsh"