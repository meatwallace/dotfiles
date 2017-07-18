#!/bin/bash -e

if [[ "$(uname -s)" == "Darwin" ]]
then
  brew tap caskroom/fonts
  brew cask install font-fira-code
else
  mkdir -p ~/.local/share/fonts

  for type in Bold Light Medium Regular Retina; do
    wget -O ~/.local/share/fonts/FiraCode-${type}.ttf \
    "https://github.com/tonsky/FiraCode/blob/master/distr/ttf/FiraCode-${type}.ttf?raw=true";
  done

  fc-cache -f
fi
