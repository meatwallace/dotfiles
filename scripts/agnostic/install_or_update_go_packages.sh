#!/bin/sh

set -eu

install_or_update_go_packages() {
  echo "go: updating to yaml.v2"

  go get -u gopkg.in/yaml.v2

  echo "go: installing packages"

  go get github.com/mattn/efm-langserver
  go get golang.org/x/tools/cmd/gopls
}

install_or_update_go_packages "$@"
