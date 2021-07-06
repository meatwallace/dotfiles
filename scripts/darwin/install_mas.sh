#!/bin/sh

set -eu

if [ ! -x "$(command -v mas)" ]; then
  brew install mas >/dev/null
fi
