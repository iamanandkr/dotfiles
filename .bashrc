# Almost everything here has been taken from generous contributors.


# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac


# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTFILESIZE=100000000
HISTSIZE=100000

# Not everything in history is interesting
HISTIGNORE="cd:ls:clear:exit"

# The next line allows me to share history between different screen terminals
# Thank you https://spin.atomicobject.com/2016/05/28/log-bash-history/
mkdir -p ~/.logs
export PROMPT_COMMAND='if [ "$(id -u)" -ne 0 ]; then echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> ~/.logs/bash-history-$(date "+%Y-%m-%d").log; fi'

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


# Alias, function definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.aliases ]; then
    . ~/.aliases
fi

if [ -f ~/.functions ]; then
    . ~/.functions
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  elif which brew &> /dev/null && [ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]; then
    # Ensure existing Homebrew v1 completions continue to work
    export BASH_COMPLETION_COMPAT_DIR="$(brew --prefix)/etc/bash_completion.d";
    source "$(brew --prefix)/etc/profile.d/bash_completion.sh";
  elif [ -f /usr/local/etc/bash_completion ]; then
    . /usr/local/etc/bash_completion
  fi
fi

# Many thanks: https://github.com/git/git/blob/master/contrib/completion/git-completion.bash (v2.33.0)
if [ ! -f ${HOME}/code/git/git-completion.bash ]; then
  echo "Downloading git-completion.bash file"
  mkdir -p ${HOME}/code/git
  curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash > ${HOME}/code/git/git-completion.bash
fi
source ${HOME}/code/git/git-completion.bash

# Git specific
# Many thanks: https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh (v2.33.0)
# Git prompt with working directory status and other helpful information.
if [ ! -f ${HOME}/code/git/git-prompt.sh ]; then
  echo "Downloading git-prompt.sh file"
  mkdir -p ${HOME}/code/git
  curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh > ${HOME}/code/git/git-prompt.sh
fi

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
source ${HOME}/code/git/git-prompt.sh

# Many thanks: https://github.com/christopheryoung/dotfiles/blob/master/.bashrc
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit"

green=$(tput setaf 2)
blue=$(tput setaf 4)
reset=$(tput sgr0)
bold=$(tput bold)
PS1='\[$green$bold\](\u@\h) \[$blue$bold\]\w\[$reset\]\[$green$bold\]$(__git_ps1 " (%s)")\[$reset\]\n\$ '


# Many thanks: https://raw.github.com/mathiasbynens/dotfiles/master/.bash_profile
# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh


# git bare repository to manage dotfiles
alias dotfiles="/usr/bin/git --git-dir=${HOME}/.dotfiles.git/ --work-tree=${HOME}"


# Many thanks:
# https://github.com/junegunn/fzf/blob/master/shell/completion.bash
# https://github.com/junegunn/fzf/blob/master/shell/key-bindings.bash
# fzf key bindings and autocompletion for bash.
if [ -f /usr/share/doc/fzf/examples/key-bindings.bash ]; then
    . /usr/share/doc/fzf/examples/key-bindings.bash
fi

if [ -f /usr/share/doc/fzf/examples/completion.bash ]; then
    . /usr/share/doc/fzf/examples/completion.bash
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash


[ -f ~/schrodinger.sh ] && source ~/schrodinger.sh

SCHNIPPETS="$HOME/builds/schnippets/bash/functions"
if [[ -e "$SCHNIPPETS" ]]; then
    . $SCHNIPPETS/autoyapf.sh
fi
