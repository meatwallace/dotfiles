#!/usr/bin/env bash

set -eo pipefail

if is not available "yarn"; then
  # source our bash_profile to ensure `asdf` is available
  # shellcheck source=../../../.bash_profile
  . "$HOME/.bash_profile"

  curl -o- -L https://yarnpkg.com/install.sh | bash &>/dev/null
fi
