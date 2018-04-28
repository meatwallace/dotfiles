#!/bin/bash -e

export PATH="$PATH:$HOME/.rvm/bin"

if [[ -s "$HOME/.rvm/scripts/rvm" ]]
then
  source "$HOME/.rvm/scripts/rvm"
fi
