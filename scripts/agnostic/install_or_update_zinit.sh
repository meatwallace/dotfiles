#!/bin/sh

set -eu

install_or_update_zinit() {
  sh -c "$(curl -fsSL https://git.io/zinit-install)"
}

install_or_update_zinit "$@"
