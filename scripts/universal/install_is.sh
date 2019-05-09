#!/usr/bin/env bash

set -euo pipefail

is_bin="$MEATBOX_BIN_DIR/is"

if [ ! -x "$is_bin" ]; then
  curl https://raw.githubusercontent.com/meatwallace/is.sh/master/is.sh -o "$is_bin"

  chmod +x "$is_bin"
fi
