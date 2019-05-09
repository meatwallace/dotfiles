#!/usr/bin/env bash

set -euo pipefail

bash_oo_dir="$MEATBOX_LIBS_DIR/bash-oo"

git-clone-or-update https://github.com/niieani/bash-oo-framework.git "$bash_oo_dir" >/dev/null

ln -fs "$bash_oo_dir"/lib/* "$MEATBOX_BIN_DIR"

# rename the bootstrap script symlink to something clearer
mv "$MEATBOX_BIN_DIR/oo-bootstrap.sh" "$MEATBOX_BIN_DIR/bash-oo"
