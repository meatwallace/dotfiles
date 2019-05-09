#!/bin/sh

set -eo pipefail

NOW_TARGET="${NOW_TARGET:-staging}"

now \
  --token "$NOW_TOKEN" \
  --target "$NOW_TARGET"

