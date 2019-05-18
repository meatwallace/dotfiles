#!/usr/bin/env bash

set -euo pipefail

if [ ! -x "$(command -v lspci)" ]; then
  yay -S --noconfirm "pciutils" >/dev/null
fi
