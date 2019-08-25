#!/bin/sh

set -eu

systemctl_units="$(systemctl list-unit-files)"

desired_services="
apparmor.service
bluetooth.service
cronie.service
docker.service
libvirtd.service
lightdm.service
snapd.apparmor.service
snapd.socket
sshd.socket
virtlogd.service
"

for service in $desired_services; do
  if echo "$systemctl_units" | grep -q "$service"; then
    sudo systemctl enable "$service" || true
    sudo systemctl start "$service" || true
  fi
done
