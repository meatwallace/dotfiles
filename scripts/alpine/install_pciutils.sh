#!/bin/sh

set -eu

if [ ! -x "$(command -v lspci)" ]; then
  apk add --no-cache pciutils
fi
