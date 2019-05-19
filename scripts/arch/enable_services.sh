#!/bin/sh

set -eu

systemctl_units="$(systemctl list-unit-files)"

desired_services="
bluetooth.service
cron.service
lightdm.service
libvirtd.service
virtlogd.service
docker.service
sshd.socket
"

for service in $desired_services; do
  if echo "$systemctl_units" | grep -q "$service"; then
    sudo systemctl enable "$service" || true
    sudo systemctl start "$service" || true
  fi
done
