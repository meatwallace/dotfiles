#!/bin/bash -e

# use gnu `ls` on mac
if [[ "$(uname -s)" == "Darwin" ]]
then
  alias ls="gls"
fi

# defaults
alias ls="ls -F --color"
alias vi="nvim"
alias vim="nvim"

# shortcuts
alias c='cd'
alias l='ls -AGF --color'
alias m='mkdir -p'
alias r='rm'
alias s='sudo'
alias t='touch'

# navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# git
alias g='git'
alias ga='git add .'
alias gc='git commit'
alias gca='git commit -a'
alias gd='git diff --color | sed "s/^\([^-+ ]*\)[-+ ]/\\1/" | less -r'
alias gf='git fetch'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gnb='git checkout -b'
alias gp='git push origin HEAD'
alias gs='git status -sb'

# apps
alias code='code-insiders'

# cli
alias rn='react-native'
alias y='yarn'

# term
alias reload!='. ~/.zshrc'
alias cls='clear'

# ssh
alias cpkey="copyq copy - < ~/.ssh/id_rsa.pub | echo 'Public key copied to pasteboard.'"
