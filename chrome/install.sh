#!/bin/bash -e

if [[ "$(uname -s)" == "Darwin" ]] && [[ ! -x "/Applications/Google Chrome.app" ]]
then
  brew cask install google-chrome
elif [[ "$(uname -s)" == "Linux" ]] && [[ ! -x "$(command -v google-chrome)" ]]
then
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo dpkg -i google-chrome-stable_current_amd64.deb
  rm google-chrome-stable-current_amd64.deb
fi
