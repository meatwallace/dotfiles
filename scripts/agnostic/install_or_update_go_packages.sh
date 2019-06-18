#!/bin/sh

set -eu

install_or_update_go_packages() {
  echo "go: installing packages"

  go get github.com/mattn/efm-langserver/cmd/efm-langserver
  go get golang.org/x/tools/cmd/gopls
}

install_or_update_go_packages "$@"
