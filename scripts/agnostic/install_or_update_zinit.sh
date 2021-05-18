#!/bin/sh

set -eu

install_or_update_zinit() {
  curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh | sh
}

install_or_update_zinit "$@"
