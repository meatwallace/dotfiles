#!/bin/sh

set -eu

setup_docker() {
  gpu_vendor="$(get-gpu-vendor)"

  sudo mkdir -p /etc/docker
  sudo cp "$HOME/.config/docker/daemon-$gpu_vendor.json" /etc/docker/daemon.json
}

setup_docker "$@"

