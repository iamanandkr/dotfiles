# Almost everything here has been taken from generous contributors.


# alias python3="$(brew --prefix python@3.11)/libexec/bin/python3"

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

_BASHRC_DIR=~/.bashrc.d

source ~/.shell_utils.sh

source ~/.aliases
source ~/.functions


# export TERM="xterm-256color"


source $_BASHRC_DIR/autocomplete.sh
source $_BASHRC_DIR/git.sh
source $_BASHRC_DIR/history.sh

if _is_darwin; then
  source $_BASHRC_DIR/darwin.sh
fi


# [ -f ~/acas.sh ] && source ~/acas.sh
[ -f ~/schrodinger.sh ] && source ~/schrodinger.sh


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
# shopt -s checkwinsize


# enable programmable completion features.


green=$(tput setaf 2)
blue=$(tput setaf 4)
reset=$(tput sgr0)
bold=$(tput bold)
PS1='\[$green$bold\]\u@mbp: \[$blue$bold\]\w\[$reset\]\[$green$bold\]$(__git_ps1 " (%s)")\[$reset\]\n\$ '





# Alias, function definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.


[ -f ~/.fzf.bash ] && source ~/.fzf.bash


export BASH_SILENCE_DEPRECATION_WARNING=1


# Many thanks: https://raw.github.com/mathiasbynens/dotfiles/master/.bash_profile
# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null; then
	complete -o default -o nospace -F _git g;
fi;

export PATH="/usr/local/bin:$PATH"
# source <(kubectl completion bash)

