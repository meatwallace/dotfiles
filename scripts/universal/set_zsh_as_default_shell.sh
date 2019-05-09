#!/usr/bin/env bash

set -euo pipefail

user="$(id -u -n)"

# set ZSH as our default shell
if is empty "$(grep "$user" </etc/passwd | grep "zsh")"; then
  if is empty "$MEATBOX_PASSWORD"; then
    chsh -s /usr/bin/zsh
  else
    echo "$MEATBOX_PASSWORD" | chsh -s /usr/bin/zsh
  fi
fi
