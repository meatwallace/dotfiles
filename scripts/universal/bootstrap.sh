#!/bin/sh

set -eu

scripts="install_or_update_asdf.sh"

for script in $scripts; do
  "./$script" >/dev/null
done
