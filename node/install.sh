#!/bin/bash -e

if [[ ! -x "$(command -v n)" ]]
then
  # install `n` for managing node versions & latest version of node
  curl -L https://git.io/n-install | bash -s -- -yq latest

  # select latest node
  n latest
else
  echo "y" | n-update
fi

if [[ ! -x "$(command -v yarn)" ]]
then
  # install yarn
  curl -o- -L https://yarnpkg.com/install.sh | bash
fi