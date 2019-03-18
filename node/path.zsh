#!/bin/bash -e

# add `n` and `node`
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"

# add `yarn` and our global modules
export PATH="$HOME/.yarn/bin:$PATH"
