#!/usr/bin/env bash

set -eo pipefail

usage() {
  cat << HEREDOC
meatbox

Usage:
  meatbox help       show this screen
  meatbox bootstrap  installs the dependencies required to use commands
  meatbox setup      configure the system as it was a clean operating system,
                     creating core directories, installing drivers and our
                     desired packages, updating our core system packages and
                     applying our customized configuration     
  meatbox update     installs & updates our desired packages, our core system
                     packages, and applies any new or updated configuration that
                     may have changed since our last run

HEREDOC
}

meatbox_run_script() {
  local directory="$1"
  local script="$2"

  (cd "$MEATBOX_SCRIPTS_DIR/$directory" && "./$script")
}

meatbox_run_universal_script() {
  local script="$1"

  meatbox_run_script "universal" "$script"
}

meatbox_run_os_script() {
  local script="$1"
  local os
  
  os="$(uname -s)"
  os="$(lowercase $os)"

  if is file "$MEATBOX_SCRIPTS_DIR/$os/$script"; then
    meatbox_run_script "$os" "$script"
  fi
}

meatbox_help() {
  usage
}

meatbox_bootstrap() {
  start-sudo-loop "$MEATBOX_PASSWORD"

  # we use `is.sh` everywhere in our scripts & `neofetch` for our `sysinfo` util
  meatbox_run_universal_script "install_is.sh"

  meatbox_run_os_script "bootstrap.sh"
  meatbox_run_universal_script "bootstrap.sh"
}

if [ "$1" = "bootstrap" ]; then
  meatbox_bootstrap

  exit 0
fi

###############################################################################
# > preflight
# ensure we've got all the dependencies our utility requires before proceeding
###

meatbox_verify_libs() {
  local bootstrapped="true"
  local bash_version="$(get-bash-version)"

  declare -a libs=(
    app-fast
    asdf
    bash-oo
    is
  )

  if is lt "$bash_version" "4"; then
    echo "Error: \`meatbox\` requires \`bash\` version 4.3 or newer."
    
    bootstrapped="false"
  fi
  
  for lib in "${libs[@]}"; do
    if [ ! -n "$(command -v "$lib")" ]; then
      echo "Error: required dependency \`$lib\` not found."
      
      bootstrapped="false"
    fi
  done

  if [ "$bootstrapped" = "false" ]; then
    echo "Please run \`meatbox bootstrap\` before proceeding"

    exit 1
  fi
}

meatbox_verify_libs

###############################################################################
# > init
# load in the framework & relevant modules
###
. bash-oo

import util/namedParameters
import util/tryCatch
import util/exception
import util/log

namespace meatbox

log_message() {
  printf "%s" "$(UI.Color.Blue)$*$(UI.Color.Default)"
}

Log::RegisterLogger MEATLOG log_message

Log::AddOutput meatbox MEATLOG

###############################################################################
# > meatbox <?command> <?...flags>
# our main utility script built on `bash-infinity`
###

meatbox_setup() {
  [...rest] flags

  start-sudo-loop "$MEATBOX_PASSWORD"
  meatbox_run_os_script "setup.sh" "$flags"
  meatbox_run_universal_script "setup.sh" "$flags"
}

meatbox_update() {
  [...rest] flags

  start-sudo-loop "$MEATBOX_PASSWORD"
  meatbox_run_os_script "update.sh" "$flags"
  meatbox_run_universal_script "update.sh" "$flags"
}

meatbox() {
  [string] cmd
  [...rest] flags
  
  try {
    case "$cmd" in
      bootstrap|setup|update ) "meatbox_$cmd" "$flags" ;;
      * ) meatbox_help ;;
    esac
  } catch {
    echo "Caught Exception:$(UI.Color.Red) $__BACKTRACE_COMMAND__ $(UI.Color.Default)"
    echo "File: $__BACKTRACE_SOURCE___, Line: $__BACKTRACE_LINE__"

    Exception::PrintException "${__EXCEPTION__[@]}"
  }
}

meatbox "$@"
