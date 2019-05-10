#!/usr/bin/env bash

declare -a scripts=(
  refresh_package_databases.sh
  update_pacman_mirrorlist.sh
  install_or_update_packages.sh
  install_or_update_x11docker.sh
  update_system_packages.sh
  update_user_groups.sh
)

for script in "${scripts[@]}"; do
  "./$script" >/dev/null
done
