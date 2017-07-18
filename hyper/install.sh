#!/bin/bash -e

if [[ "$(uname -s)" == "Darwin" ]] && [[ ! -x "/Applications/Hyper.app" ]]
then
  brew cask install hyper
elif [[ "$(uname -s)" == "Linux" ]] && [[ ! -x "$(command -v hyper)" ]]
then
  # source
  wget --output-document=hyperterm.deb https://hyper-updates.now.sh/download/linux_deb
  sudo dpkg -i hyperterm.deb
  rm hyperterm.deb
fi
