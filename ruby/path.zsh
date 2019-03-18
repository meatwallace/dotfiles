#!/bin/bash -e

export PATH="$HOME/.rvm/bin:$PATH"

if [[ -s "$HOME/.rvm/scripts/rvm" ]]
then
  source "$HOME/.rvm/scripts/rvm"
fi
