#!/bin/sh

set -eu

openrc_units="$(sudo rc-update show -v)"

desired_services="
bluetooth
docker
dcron
lightdm
libvirtd
sshd
virtlogd
"

for service in $desired_services; do
  if echo "$openrc_units" | grep -q "$service"; then
    sudo rc-update add "$service"
  fi
done
