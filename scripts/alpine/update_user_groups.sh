#!/bin/sh

set -eu

username="$(id -u -n)"

# lg
# libvirt

groups="
  docker
"

for group in $groups; do
  sudo adduser "$username" "$group"
done
