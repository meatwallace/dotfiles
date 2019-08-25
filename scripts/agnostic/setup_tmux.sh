#!/bin/sh

set -eu

setup_tmux() {
  echo "tmux: installing plugins"

  git-clone-or-update https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm >/dev/null
  git-clone-or-update https://github.com/tmux-plugins/tmux-sensible ~/.tmux/plugins/tmux-sensible >/dev/null
  git-clone-or-update https://github.com/tmux-plugins/tmux-pain-control ~/.tmux/plugins/tmux-pain-control >/dev/null
  git-clone-or-update https://github.com/christoomey/vim-tmux-navigator ~/.tmux/plugins/vim-tmux-navigator >/dev/null
  git-clone-or-update https://github.com/tmux-plugins/tmux-open ~/.tmux/plugins/tmux-open >/dev/null
  git-clone-or-update https://github.com/tmux-plugins/tmux-yank ~/.tmux/plugins/tmux-yank >/dev/null
  git-clone-or-update https://github.com/tmux-plugins/tmux-resurrect ~/.tmux/plugins/tmux-resurrect >/dev/null
  git-clone-or-update https://github.com/tmux-plugins/tmux-continuum ~/.tmux/plugins/tmux-continuum >/dev/null
  git-clone-or-update https://github.com/wfxr/tmux-fzf-url ~/.tmux/plugins/tmux-fzf-url >/dev/null
}

setup_tmux "$@"
