#!/usr/bin/env bash

set -euo pipefail

(
cd "$HOME" && \
gem install bundler >/dev/null && \
bundle update >/dev/null
)
