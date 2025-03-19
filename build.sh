#!/usr/bin/env bash

echo "#!/usr/bin/env bash" > install.sh

cat << 'EOF' > install.sh
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_STATE_HOME="$HOME"/.local/state
export XDG_RUNTIME_DIR="$TMPDIR"
EOF

cat lib/colors.sh lib/logging.sh lib/install.sh >> install.sh

chmod +x install.sh