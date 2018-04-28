#!/bin/bash -e

# replacements
alias ls="gls -F --color"

# shortcuts
alias c='cd'
alias l='gls -AGF --color'
alias m='mkdir -p'
alias r='rm'
alias s='sudo'
alias t='touch'

# navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# apps
alias code='code-insiders'

# dirs
alias dl='cd ~/learning'
alias dp='cd ~/projects'

# cli
alias rn='react-native'
alias y='yarn'

# term
alias reload!='. ~/.zshrc'
alias cls='clear'
