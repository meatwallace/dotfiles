#!/bin/bash -e

# install
if [[ "$(uname -s)" == "Darwin" ]] && [[ ! -x "$(command -v atom)" ]]
then
  brew cask install atom
elif [[ "$(uname -s)" == "Linux" ]] && [[ ! -x "$(command -v atom-beta)" ]]
then
  # source
  curl -sL https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
  sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'

  sudo aptitude -q -y install atom-beta
fi

ATOM="$HOME/.atom"

# if this is our first run, the folder wont exist
if [[ ! -d "$ATOM" ]]; then
  mkdir -p "$ATOM"
fi

# symlink dotfiles
rm -rf "${ATOM}"

ln -s "${ZSH}/atom" "${ATOM}"

# install packages
if [[ -x "$(command -v apm)" ]]
then
  apm stars --user meatwallace --install
fi
