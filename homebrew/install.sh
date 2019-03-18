#!/bin/bash -e

if [[ "$(uname -s)" == "Darwin" ]] && [[ ! -x "$(command -v brew)" ]]
then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
