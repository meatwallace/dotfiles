#!/bin/sh

set -eu

(
  cd "$HOME"
  gem install bundler >/dev/null
  bundle update >/dev/null
)
