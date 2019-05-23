#!/bin/sh

set -eu

if ! command -v circleci >/dev/null; then
  curl -fLSs https://circle.ci/cli | sudo bash
else
  sudo circleci update
fi
