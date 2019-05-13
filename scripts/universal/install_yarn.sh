#!/bin/sh

set -e

if [ ! -x "$(command -v yarn)" ]; then
  # source our bash_profile to ensure `asdf` is available
  # shellcheck source=../../.bash_profile
  . "$HOME/.bash_profile"

  curl -o- -L https://yarnpkg.com/install.sh | bash >/dev/null 2>&1
fi
