#!/usr/bin/env bash

set -euo pipefail

username="$(id -u -n)"

sudo usermod -aG docker "$username"
sudo usermod -aG libvirt "$username"
