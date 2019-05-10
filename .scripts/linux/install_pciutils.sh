#!/usr/bin/env bash

set -euo pipefail

if is not available "lspci"; then
  yay -S --noconfirm "pciutils" >/dev/null
fi
