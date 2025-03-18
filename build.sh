#!/usr/bin/env bash

echo "#!/usr/bin/env bash" > install.sh

cat << 'EOF' > install.sh
declare -rx XDG_CACHE_HOME="$HOME"/.cache
declare -rx XDG_CONFIG_HOME="$HOME"/.config
declare -rx XDG_DATA_HOME="$HOME"/.local/share
declare -rx XDG_STATE_HOME="$HOME"/.local/state
declare -rx XDG_RUNTIME_DIR="$TMPDIR"
EOF

cat lib/colors.sh lib/logging.sh lib/install.sh >> install.sh

chmod +x install.sh