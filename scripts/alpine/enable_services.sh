#!/bin/sh

set -eu

username="$(id -u -n)"

# lightdm
# libvirtd
# virtlogd

services="
  bluetooth
  docker
  sshd
"

for service in $services; do
  sudo rc-update add "$service"
done
