#!/bin/sh

set -eu

packages="$(grep -v '^\#' ./APKFile | grep .)"

# shellcheck disable=SC2086
apk add --no-cache $packages
