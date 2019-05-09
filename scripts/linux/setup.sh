#!/usr/bin/env bash

# ensure we have a fonts directory
mkdir -p "$HOME/.local/share/fonts"

declare -a scripts=(
  refresh_package_databases.sh
  update_pacman_mirrorlist.sh
  install_or_update_packages.sh
  install_or_update_x11docker.sh
  install_gpu_drivers.sh
  update_system_packages.sh
  update_user_groups.sh
  enable_services.sh
  update_package_configuration.sh
)

for script in "${scripts[@]}"; do
  "./$script" >/dev/null
done
