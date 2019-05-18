#!/bin/sh

set -eu

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
