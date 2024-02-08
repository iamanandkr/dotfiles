_BASHRC_GIT_DIR=$_BASHRC_DIR/git


# Git completion
_GIT_COMPLETION_PATH=$_BASHRC_GIT_DIR/git-completion.bash
if [ ! -f $_GIT_COMPLETION_PATH ]; then
    curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o $_GIT_COMPLETION_PATH
fi
source $_BASHRC_GIT_DIR/git-completion.bash


# Git prompt
_GIT_PROMPT_PATH=$_BASHRC_GIT_DIR/git-prompt.sh
if [ ! -f $_GIT_PROMPT_PATH ]; then
    curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o $_GIT_PROMPT_PATH
fi
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
source $_BASHRC_GIT_DIR/git-prompt.sh


# Git aliases
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.cp cherry-pick
git config --global alias.df diff
git config --global alias.dfs 'diff --staged'
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit"