#!/bin/sh

set -eu

# update_apk_mirrorlist.sh
# install_gpu_drivers.sh
scripts="
refresh_package_databases.sh
install_or_update_packages.sh
update_system_packages.sh
update_user_groups.sh
enable_services.sh
update_openrc_config.sh
update_package_configuration.sh
"

setup() {
  for script in $scripts; do
    "./$script" # >/dev/null
  done
}

setup
