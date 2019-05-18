#!/bin/sh

set -eu

# apparmor.service
# snapd.socket
# snapd.apparmor.service

services="
  bluetooth.service
  lightdm.service
  libvirtd.service
  virtlogd.service
  docker.service
  sshd.socket
"

for service in $services; do
  sudo systemctl enable --now "$service"
done
