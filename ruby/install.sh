#!/bin/bash -e

if [[ ! -x "$(command -v rvm)" ]]
then
  # add rvm repo if on linux
  if [[ "$(uname -s)" == "Linux" ]]
  then
    sudo apt-add-repository -y ppa:rael-gc/rvm
    sudo apt-get -q -y update
  fi

  # gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB

  \curl -sSL https://get.rvm.io | bash
fi

if [[ ! -x "$(command -v ruby)" ]]
then
  rvm install ruby

  rvm use ruby --default
fi
