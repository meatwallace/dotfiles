#!/usr/bin/env bash

set -euo pipefail

gpu_vendor="$(get-gpu-vendor)"

if is equal "$gpu_vendor" "nvidia" && is not a file "/etc/X11/xorg.conf.d/20-nvidia.conf"; then
  yay -S --noconfirm nvidia nvidia-settings >/dev/null

  # generate an X11 config using NVIDIA's tool
  sudo nvidia-xconfig --output-xconfig="/etc/X11/xorg.conf.d/20-nvidia.conf" >/dev/null
fi

if is equal "$gpu_vendor" "amd"; then
  echo "TODO(#28): install AMD/ATI GPU drivers if detected"
fi
