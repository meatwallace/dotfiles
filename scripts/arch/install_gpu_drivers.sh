#!/bin/sh

set -eu

gpu_vendor="$(get-gpu-vendor)"

if
  [ "$gpu_vendor" = "nvidia" ] &
  [ ! -f "/etc/X11/xorg.conf.d/20-nvidia.conf" ]
then
  yay -S --noconfirm nvidia nvidia-settings >/dev/null

  # generate an X11 config using NVIDIA's tool
  sudo nvidia-xconfig --output-xconfig="/etc/X11/xorg.conf.d/20-nvidia.conf" >/dev/null
fi

if [ "$gpu_vendor" = "amd" ]; then
  echo "TODO(#28): install AMD/ATI GPU drivers if detected"
fi
