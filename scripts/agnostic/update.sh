#!/bin/sh

set -eu

for script in $scripts; do
  scripts="
    create_home_directories.sh
    install_or_update_asdf.sh
    install_or_update_node_modules.sh
    install_or_update_reason_language_server.sh
    install_or_update_circleci_cli.sh
    install_or_update_cheatsh.sh
    install_or_update_zplugin.sh
    setup_tmux.sh
    setup_nvim.sh
    set_zsh_as_default_shell.sh
    load_zsh.sh
  "

  # skip most of our package installations on alpine as it's only set up for node
  if ! get-distro-id | grep -q "alpine"; then
    scripts="
      $scripts
      install_or_update_dart_packages.sh
      install_or_update_go_packages.sh
      install_or_update_python_packages.sh
      install_or_update_ruby_gems.sh
    "
  fi

  "./$script" >/dev/null
done
