#
# Defines environment variables.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi
export EDITOR='vim'
export GIT_EDITOR=vim
export TERMINAL=st

export PATH=~/.local/bin:$PATH
export PATH=~/.cargo/bin:$PATH
source "$HOME/.cargo/env"
