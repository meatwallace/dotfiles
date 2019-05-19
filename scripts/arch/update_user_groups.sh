#!/bin/sh

set -eu

username="$(id -u -n)"

groups="$(cat /etc/group)"
desired_groups="docker libvirt lp"

for group in $desired_groups; do
  if echo "$groups" | grep -q "$group"; then
    sudo usermod -aG "$group" "$username"
  fi
done
