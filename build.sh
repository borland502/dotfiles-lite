#!/usr/bin/env bash

echo "#!/usr/bin/env bash" > install.sh
cat lib/colors.sh lib/logging.sh lib/install.sh >> install.sh

chmod +x install.sh