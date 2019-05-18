#!/bin/sh

set -eu

packages="$(grep -v '^\#' ./APKFile | grep .)"

apk add --no-cache $packages
