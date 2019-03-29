#!/usr/bin/env bash

if is available "brew"; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" >/dev/null
else
  brew update >/dev/null
fi

