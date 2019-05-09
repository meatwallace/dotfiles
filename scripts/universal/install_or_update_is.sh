#!/usr/bin/env bash

set -euo pipefail

is_dir="$MEATBOX_LIBS_DIR/is"

git-clone-or-update https://github.com/meatwallace/is.sh.git "$is_dir" >/dev/null

ln -fs "$is_dir/is.sh" "$MEATBOX_BIN_DIR/is"
