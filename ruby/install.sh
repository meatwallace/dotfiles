#!/bin/bash -e

if [[ ! -x "$(command -v rvm)" ]]
then
  gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB

  curl -sSL https://get.rvm.io | bash -s -- --auto-dotfiles
fi

if [[ ! -x "$(command -v ruby)" ]]
then
  rvm install ruby

  rvm use ruby --default
fi
