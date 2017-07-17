#!/bin/bash -e

if [[ -x "$(command -v brew >/dev/null 2>&1)" ]]
then
  if [[ "$(uname -s)" == "Darwin" ]]
  then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  else
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
  fi
fi
