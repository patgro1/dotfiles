# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export TERM="xterm-256color"

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes

#Powerline configuration
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(virtualenv host dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(load date time)
source ~/.pure_power
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

# -- This function is fixing the ssh forwarding
# If not in tmux, update the DISPLAY cache
# If in TMUX, read the display cache
function update_x11_forwarding {
    if [ -z "$TMUX" ]; then
        echo $DISPLAY > ~/.display.txt
    else
        export DISLAY=`cat ~/.display.txt`
    fi
}
preexec() {
    update_x11_forwarding
}

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
export VIM_CONFIG=~/.config/nvim/init.vim
alias vim='nvim'
alias vi='nvim'
export EDITOR='nvim'
export GIT_EDITOR=nvim

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias adog="git log --all --decorate --oneline --graph"
alias ll="ls -al"
alias tmux="tmux -2"
if [[ -r ~/.zshrc_local ]]; then
    source ~/.zshrc_local
fi
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source ~/.tmuxinator.zsh
