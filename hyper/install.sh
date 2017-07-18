#!/bin/bash -e

if [[ ! -x "$(command -v hyper)" ]]
then
  if [[ "$(uname -s)" == "Darwin" ]]
  then
    brew cask install hyper
  else
    wget --output-document=hyperterm.deb https://hyper-updates.now.sh/download/linux_deb
    sudo dpkg -i hyperterm.deb
    rm hyperterm.deb
  fi
fi
