#!/bin/bash -e

QUOKKA=$HOME/.quokka

if [[ -d "$QUOKKA" ]]; then
  # cleanup existing config
  rm -f "${QUOKKA}/config.json"
else
  mkdir "$QUOKKA"
fi


# symlink our config
ln -s "${ZSH}/quokka/config.json" "${QUOKKA}/config.json"
