#/usr/bin/env zsh

# load in our path that will be searched for commands
# shellcheck source=.zpath
. "$HOME/.zpath"

# grab all of our zsh functions from ~/.zfuncs and mark them for autoloading 
function () {
  local -a zfuncs

  for func in "$HOME"/.zfuncs/*(.); do 
    zfuncs+="$(basename $func)"
  done

  autoload -Uz "$zfuncs[@]"
}

# prompt & command configuration
setopt AUTOCD                     # automatically swap to a directory without requiring to type `cd`
setopt PROMPT_SUBST               # enable parameter expansion, command substituion, and arithmetic expansion in prompts
setopt CORRECT                    # try to correct the spelling of our commands
setopt NO_LIST_BEEP               # don't beep on an ambiguous completion

# directory stack
setopt AUTOPUSHD                  # automatically push directories into the stack
setopt PUSHDIGNOREDUPS            # don't push duplicates into the directory stack

# history
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000

setopt BANG_HIST                  # treat the '!' character specially during expansion
setopt EXTENDED_HISTORY           # write the history file in the ":start:elapsed;command" format
setopt SHARE_HISTORY              # share history between all sessions
setopt HIST_EXPIRE_DUPS_FIRST     # expire duplicate entries first when trimming history
setopt HIST_IGNORE_DUPS           # don't record an entry that was just recorded again
setopt HIST_IGNORE_ALL_DUPS       # delete old recorded entry if new entry is a duplicate
setopt HIST_FIND_NO_DUPS          # do not display a line previously found
setopt HIST_IGNORE_SPACE          # don't record an entry starting with a space
setopt HIST_SAVE_NO_DUPS          # don't write duplicate entries in the history file
setopt HIST_REDUCE_BLANKS         # remove superfluous blanks before recording entry
setopt HIST_VERIFY                # don't execute immediately upon history expansion

# background commands
setopt NO_BG_NICE                 # don't run background commands at a lower priority
setopt NO_NOTIFY                  # don't notify us of background commands finishing
setopt NO_HUP                     # don't kill background commands if the spawning shell is exiting

# functions
setopt LOCAL_OPTIONS              # allow functions to have local options
setopt LOCAL_TRAPS                # allow functions to have local traps

# matches case insensitive for lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# pasting with tabs doesn't perform completion
# zstyle ':completion:*' insert-tab pending

# menu-driven auto completion
# zstyle ':completion:*' menu select

# initialize our completion
autoload -Uz bashcompinit && bashcompinit
autoload -Uz compinit && compinit

# shellcheck source=.zcompletions
. "$HOME/.zcompletions"

# shellcheck source=.zaliases
. "$HOME/.zaliases"

# initialize zplugin
. '/home/meatwallace/.zplugin/bin/zplugin.zsh'
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

# plugins

# theme: pure
# zplugin ice pick"async.zsh" src"pure.zsh"
# zplugin light sindresorhus/pure

# theme: spaceship
# zplugin ice src"spaceship.zsh"
# zplugin light denysdovhan/spaceship-prompt

# theme: purepower
. ~/.purepower
zplugin ice src"powerlevel10k.zsh-theme"
zplugin light romkatv/powerlevel10k

# enforce vi-mode rather than zsh's default emacs mode
# unsetopt ZLE
bindkey -v
KEYTIMEOUT=1

# export FZF_COMPLETION_TRIGGER=''
. /usr/share/fzf/key-bindings.zsh
. /usr/share/fzf/completion.zsh
# bindkey '^T' fzf-completion
#bindkey '^I' $fzf_default_completion

