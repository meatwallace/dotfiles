#!/bin/sh

set -eu

NOW_TARGET="${NOW_TARGET:-staging}"

now \
  --token "$NOW_TOKEN" \
  --target "$NOW_TARGET"
