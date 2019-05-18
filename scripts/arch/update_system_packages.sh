#!/bin/sh

set -eu

# upgrade our system packages
yay -Su --noconfirm >/dev/null
