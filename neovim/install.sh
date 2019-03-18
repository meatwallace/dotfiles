#!/bin/bash -e

# ensure our the neovim config directory exists
mkdir -p ~/.config/nvim

# symlink our .vimrc file so that it's available to neovim
rm -f ~/.config/nvim/init.vim
ln -s ~/.vimrc ~/.config/nvim/init.vim

