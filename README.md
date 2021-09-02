# dotfiles

Using [The best way to store your dotfiles: A bare Git repository](https://www.atlassian.com/git/tutorials/dotfiles) infrastructure to maintain the dotfiles.

### Getting started

```bash
cd ~
alias dotfiles="/usr/bin/git --git-dir=${HOME}/.dotfiles.git/ --work-tree=${HOME}"
echo ".dotfiles" >> .gitignore
git clone --bare <git-repo-url> $HOME/.dotfiles.git
dotfiles checkout
```
