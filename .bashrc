# Almost everything here has been taken from generous contributors.


# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac


# Bash environment variables to control history settings.
# See https://www.gnu.org/software/bash/manual/html_node/Bash-Variables.html
HISTCONTROL=ignoreboth  # Skip duplicates and commands beginning with a space
HISTFILESIZE=100000000
HISTSIZE=100000
HISTIGNORE="cd:ls:clear:exit"

shopt -s histappend  # append to the history file, don't overwrite it


# The next line allows me to share history between different screen terminals
# Thank you https://spin.atomicobject.com/2016/05/28/log-bash-history/
mkdir -p ~/.logs
export PROMPT_COMMAND='if [ "$(id -u)" -ne 0 ]; then echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> ~/.logs/bash-history-$(date "+%Y-%m-%d").log; fi;'


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


# enable programmable completion features.
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

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
PS1='\[$green$bold\]\u@mbp: \[$blue$bold\]\w\[$reset\]\[$green$bold\]$(__git_ps1 " (%s)")\[$reset\]\n\$ '


# git bare repository to manage dotfiles
alias dotfiles="/usr/bin/git --git-dir=${HOME}/.dotfiles.git/ --work-tree=${HOME}"


# Alias, function definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.


[ -f ~/.fzf.bash ] && source ~/.fzf.bash

[ -f ~/schrodinger.sh ] && source ~/schrodinger.sh

if [ -f ~/.aliases ]; then
    . ~/.aliases
fi

if [ -f ~/.functions ]; then
    . ~/.functions
fi

SCHNIPPETS="$HOME/builds/schnippets/bash/functions"
if [[ -e "$SCHNIPPETS" ]]; then
    . $SCHNIPPETS/autoyapf.sh
fi

export BASH_SILENCE_DEPRECATION_WARNING=1


# Many thanks: https://raw.github.com/mathiasbynens/dotfiles/master/.bash_profile
# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null; then
	complete -o default -o nospace -F _git g;
fi;

export PATH="/usr/local/bin:$PATH"
source <(kubectl completion bash)

