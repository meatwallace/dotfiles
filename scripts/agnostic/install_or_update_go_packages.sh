#!/bin/sh

set -eu

trap revert_gitconfig 1 2 3 6

revert_gitconfig() {
  mv "$HOME/.gitconfig.bak" "$HOME/.gitconfig"
}

install_or_update_go_packages() {
  echo "go: installing packages"

  # TODO: remove this hacky workaround. as we force git to use SSL for github
  # URLs, it inteferes with `go get` prior to our SSL certificate being
  # installed, so we temporarily shift our config file and then shift it back
  mv "$HOME/.gitconfig" "$HOME/.gitconfig.bak"

  go get github.com/mattn/efm-langserver/cmd/efm-langserver
  go get golang.org/x/tools/cmd/gopls

  revert_gitconfig
}

install_or_update_go_packages "$@"
