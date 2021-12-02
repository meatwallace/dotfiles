#!/bin/sh

set -eu

scripts="
refresh_package_databases.sh
install_or_update_packages.sh
install_gpu_drivers.sh
update_system_packages.sh
setup_docker.sh
enable_services.sh
update_package_configuration.sh
update_user_groups.sh
"

update() {
  for script in $scripts; do
    "./$script" "$@"
  done
}

update "$@"
