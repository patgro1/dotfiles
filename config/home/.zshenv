export XDG_CONFIG_HOME="$HOME/.config/"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export EDITOR="nvim"
export VISUAL="nvim"

export PATH=~/.local/bin:$PATH
export PATH=~/.emacs.d/bin:$PATH

if [ -d "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi
