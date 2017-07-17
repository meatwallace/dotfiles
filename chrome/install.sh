#!/bin/bash -e

if [[ -x "$(command -v hyper >/dev/null 2>&1)" ]]
then
  if [[ "$(uname -s)" == "Darwin" ]]
  then
    brew cask install google-chrome
  else
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg -i google-chrome-stable_current_amd64.deb
    rm google-chrome-stable-current_amd64.deb
  fi
fi
