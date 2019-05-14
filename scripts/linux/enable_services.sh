#!/usr/bin/env bash

set -euo pipefail

declare -a services=(
  bluetooth.service
  lightdm.service
  libvirtd.service
  virtlogd.service
  docker.service
  # apparmor.service
  # snapd.socket
  # snapd.apparmor.service
)

# enable all of our required services
for service in "${services[@]}"; do
  sudo systemctl enable --now "$service"
done

# enable classic snap support
# sudo ln -fs /var/lib/snapd/snap /snap
