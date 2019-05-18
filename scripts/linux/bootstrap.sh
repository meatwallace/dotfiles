#!/bin/sh

set -eu

scripts=""

bootstrap() {
  for script in $scripts; do
    "./$script" >/dev/null
  done
}

bootstrap
