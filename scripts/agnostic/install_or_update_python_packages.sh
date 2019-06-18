#!/bin/sh

set -eu

install_or_update_python_packages() {
  pip install --user --upgrade \
    black \
    jedi \
    pip \
    pylint \
    pynvim \
    python-language-server[yapf] \
    pyls-black \
    vim-vint
}

install_or_update_python_packages "$@"
