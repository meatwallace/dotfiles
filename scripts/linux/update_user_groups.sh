#!/bin/sh

set -eu

username="$(id -u -n)"

# bluetooth
sudo usermod -aG lg "$username"

# virtualization
sudo usermod -aG libvirt "$username"

# docker
sudo usermod -aG docker "$username"
