#!/bin/bash -e

if [[ ! -d ~/.zprezto ]]
then
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
fi