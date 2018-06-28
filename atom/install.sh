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
rm -f "${ATOM}/config.cson"
rm -f "${ATOM}/github.cson"
rm -f "${ATOM}/init.coffee"
rm -f "${ATOM}/keymap.cson"
rm -f "${ATOM}/snippets.cson"
rm -f "${ATOM}/styles.less"
rm -f "${ATOM}/packages.cson"

ln -s "${ZSH}/atom/config.cson" "${ATOM}/config.cson"
ln -s "${ZSH}/atom/packages.cson" "${ATOM}/packages.cson"
ln -s "${ZSH}/atom/github.cson" "${ATOM}/github.cson"
ln -s "${ZSH}/atom/init.coffee" "${ATOM}/init.coffee"
ln -s "${ZSH}/atom/keymap.cson" "${ATOM}/keymap.cson"
ln -s "${ZSH}/atom/snippets.cson" "${ATOM}/snippets.cson"
ln -s "${ZSH}/atom/styles.less" "${ATOM}/styles.less"
