#!/bin/sh

set -eu

if [ ! -x "$(command -v lspci)" ]; then
  yay -S --noconfirm "pciutils" >/dev/null
fi
