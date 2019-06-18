#!/bin/sh

set -eu

if ! grep "$(id -u -n)" </etc/passwd | grep -q "zsh"; then
  zsh_bin="$(grep --max-count=1 zsh </etc/shells)"

  if [ -z "$MEATBOX_PASSWORD" ]; then
    chsh -s "$zsh_bin"
  else
    echo "$MEATBOX_PASSWORD" | chsh -s "$zsh_bin"
  fi
fi
