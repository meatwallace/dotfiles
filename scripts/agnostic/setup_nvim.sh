#!/bin/sh

set -eu

mkdir -p "$HOME/.vim/files/backup" || true
mkdir -p "$HOME/.vim/files/swap" || true
mkdir -p "$HOME/.vim/files/undo" || true

# symlink our vim config into the .vim folder
ln -fs "$HOME/.vimrc" "$HOME/.vim/init.vim"

# symlink our vim folder into our config folder
ln -fs "$HOME/.vim" "$HOME/.config/nvim"

