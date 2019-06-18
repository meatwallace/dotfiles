#!/bin/sh

set -eu

install_or_update_lua_rocks() {
  echo "luarocks: installing rocks"

  luarocks install --server=http://luarocks.org/dev lua-lsp
}

install_or_update_lua_rocks "$@"
