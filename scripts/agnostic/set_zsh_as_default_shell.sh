#!/bin/sh

set -eu

user="$(id -u -n)"

# set ZSH as our default shell
if grep "$user" </etc/passwd | grep "zsh"; then
  if [ -z "$MEATBOX_PASSWORD" ]; then
    chsh -s /usr/bin/zsh
  else
    echo "$MEATBOX_PASSWORD" | chsh -s /usr/bin/zsh
  fi
fi
