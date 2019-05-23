#!/bin/sh

set -eu

packages="$(grep -v '^\#' ./APKFile | grep .)"

# shellcheck disable=SC2086
sudo apk add --no-cache $packages >/dev/null
