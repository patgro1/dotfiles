DISTRO=$(lsb_release -d | awk -F"\t" '{print $2}')
export XDG_CONFIG_HOME="${HOME}/.config"

# Zinit bootstrapping
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "$ZINIT_HOME/zinit.zsh"

COMPLETION_CACHE_DIR="${HOME}/.cache/zinit/completions"
if [ ! -d "$COMPLETION_DIR" ]; then
    mkdir -p "$(dirname $COMPLETION_CACHE_DIR)"
fi

zinit ice depth=1
# Adding basic functionality
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light Aloxaf/fzf-tab

# Some autosuggestions and autocomplete taken from oh my zsh
zinit snippet OMZL::git.zsh
zinit snippet OMZP::command-not-found
zinit snippet OMZP::git
zinit snippet OMZP::rust
zinit snippet OMZP::ssh
zinit snippet OMZP::sudo

if [[ $DISTRO =~ "Ubuntu" ]];
then
    zinit snippet OMZP::ubuntu
fi

# Autoload completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# Set vim keybinds
export VISUAL="nvim"
export EDITOR="nvim"
bindkey -v

OH_MY_POSH_INSTALL_DIR="$HOME"/.local/bin
OH_MY_POSH_CONFIG_FILE="${XDG_CONFIG_HOME}/oh-my-posh/config.toml"
# Install Oh my Posh
if [[ ! -a ${OH_MY_POSH_INSTALL_DIR}/oh-my-posh ]]; 
then
    curl -s https://ohmyposh.dev/install.sh | bash -s -- -d $OH_MY_POSH_INSTALL_DIR
fi

eval "$(oh-my-posh init zsh --config ${OH_MY_POSH_CONFIG_FILE})"

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
# zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
#
alias ls='ls --color'
alias ll='ls -l'

