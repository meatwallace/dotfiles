#!/bin/bash -e

if [[ ! -x "$HOME/bin/wd" ]]
then
  curl -L https://github.com/mfaerevaag/wd/raw/master/install.sh | sh
fi
