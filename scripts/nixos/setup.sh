#!/bin/sh

set -eu

scripts=""

setup() {
  for script in $scripts; do
    "./$script" >/dev/null
  done

  nixos-rebuild switch
}

setup "$@"
