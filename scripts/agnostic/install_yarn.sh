#!/bin/sh

set -eu

install_yarn() {
  if [ ! -x "$(command -v yarn)" ]; then
    # source our bashrc to make sure `asdf` is available
    set +u
    # shellcheck source=../../.bashrc
    . "$HOME/.bashrc"
    set -u

    meatman add yarn
  fi
}

install_yarn
