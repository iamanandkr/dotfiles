# Many thanks:
# https://github.com/mathiasbynens/dotfiles/blob/master/.aliases
# https://github.com/christopheryoung/dotfiles/blob/master/.aliases

# Easier navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."


# Press F1 to open the file with less without leaving fzfi
# Press CTRL-Y to copy the line to clipboard and aborts fzf (requires pbcopy)
alias fzf="fzf --bind 'f1:execute(less -f {}),ctrl-y:execute-silent(echo {} | pbcopy)+abort'"
