# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config//zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source $ZDOTDIR/.zsh_aliases
source $ZDOTDIR/.zsh_utils

# Colored prompt
autoload -U colors && colors
# ZSH options
setopt AUTO_CD

zsh-add-plugin "zsh-users/zsh-syntax-highlighting"
zsh-add-plugin "romkatv/powerlevel10k"

source $ZDOTDIR/.zsh-vi-mode
source $ZDOTDIR/zsh-completion

# We can source a local zshrc if it exists in the $HOME folder
if [ -f "$HOME/.zshrc_local" ]; then
    source "$HOME/.zshrc_local"
fi

# To customize prompt, run `p10k configure` or edit ~/.config//zsh/.p10k.zsh.
[[ ! -f ~/.config//zsh/.p10k.zsh ]] || source ~/.config//zsh/.p10k.zsh
