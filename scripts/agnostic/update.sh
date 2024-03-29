#!/bin/sh

set -eu

update() {
  scripts="
    create_home_directories.sh
    install_or_update_zinit.sh
    set_zsh_as_default_shell.sh
    load_zsh.sh
    setup_tmux.sh
    setup_nvim.sh
    install_yarn.sh
    install_or_update_go_packages.sh
    install_or_update_python_packages.sh
    install_or_update_ruby_gems.sh
  "

  for script in $scripts; do
    "./$script"
  done
}

update "$@"
