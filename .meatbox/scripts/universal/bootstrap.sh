#!/usr/bin/env bash

set -euo pipefail

declare -a scripts=(
  install_or_update_is.sh
  install_or_update_bash_oo.sh
  install_or_update_app_fast.sh
  install_or_update_asdf.sh
  install_or_update_wd.sh
)

for script in "${scripts[@]}"; do
  "./$script" >/dev/null
done
