# Cp with progress
alias cpv "command rsync -poghb --backup-dir=/tmp/rsync -e /dev/null --progress --"
alias cpvr "command rsync -rpoghb --backup-dir=/tmp/rsync -e /dev/null --progress --"

# Git
alias gst "command git status"
alias adog "command git log --all --decorate --oneline --graph"
alias gf "command git fetch --all"
alias gc "command git commit"
alias gpr "command git pull --rebase"
alias gco "command git checkout"
alias gp "command git push"
alias gpo "command git push origin"
alias gpl "command git pull"
alias gplo "command git pull origin"
alias lg "command lazygit"

alias top "command ytop -p"

alias tmux_switch "tmux_sessionizer $HOME/workspace $HOME/dotfiles"
