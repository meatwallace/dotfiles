#!/usr/bin/env bash

set -euo pipefail

wd_dir="$MEATBOX_LIBS_DIR/wd"

git-clone-or-update https://github.com/meatwallace/wd "$wd_dir"
