#!/usr/bin/env bash

set -euo pipefail

now \
  --token "$NOW_TOKEN" \
  --local-config "$MEATBOX_DIR/now.json" \
  --target "$NOW_TARGET"
