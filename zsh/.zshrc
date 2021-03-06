#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
alias vim='nvim'
alias vi='nvim'
alias adog="git log --all --decorate --oneline --graph"
alias gst="git status"
alias ll="ls -al"
alias tmux="tmux -2"

bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

if [[ -r ~/.zshrc_local ]]; then
    source ~/.zshrc_local
fi
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PIPENV_PYTHON="$PYENV_ROOT/shims/python"
export PIPENV_PYTHON="~.pyenv/versions/"

# Prompt customization
SPACESHIP_PROMPT_ORDER=(
#  time          # Time stamps section
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  package       # Package version
  docker        # Docker section
  venv          # virtualenv section
  #pyenv         # Pyenv section
  kubecontext   # Kubectl context section
  exec_time     # Execution time
  #line_sep      # Line break
  battery       # Battery level and status
  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)
SPACESHIP_RPROMPT_ORDER=(
  time
)
SPACESHIP_TIME_SHOW=true
SPACESHIP_USER_SHOW=true
SPACESHIP_GIT_STATUS_COLOR=green

neofetch
