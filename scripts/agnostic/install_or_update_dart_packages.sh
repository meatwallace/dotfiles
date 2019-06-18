#!/bin/sh

set -eu

install_or_update_dart_packages() {
  echo "dart: installing packages"

  pub global activate dart_language_server >/dev/null
}

install_or_update_dart_packages "$@"
