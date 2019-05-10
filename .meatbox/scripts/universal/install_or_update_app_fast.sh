#!/usr/bin/env bash

set -euo pipefail

app_fast_dir="$MEATBOX_LIBS_DIR/app-fast"

kernel="$(uname -s)"

if is equal "$kernel" "Darwin"; then
  app_fast_dir="usr/local/bin/app-fast"
fi

git-clone-or-update https://github.com/meatwallace/app-fast.git "$app_fast_dir" >/dev/null

chmod +x "$app_fast_dir/app-fast"

ln -fs "$app_fast_dir/app-fast" "$MEATBOX_BIN_DIR/app-fast"
