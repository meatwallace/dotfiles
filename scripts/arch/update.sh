#!/bin/sh

set -eu

scripts="
refresh_package_databases.sh
update_pacman_mirrorlist.sh
install_or_update_packages.sh
install_gpu_drivers.sh
update_system_packages.sh
update_user_groups.sh
enable_services.sh
update_package_configuration.sh
"

update() {
  for script in $scripts; do
    "./$script" >/dev/null
  done
}

update
