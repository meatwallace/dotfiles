#!/bin/sh

set -eu

install_yarn() {
  if ! command -v yarn; then
    cd "$HOME" && \
    npm install -g yarn
  fi
}

install_yarn "$@"
