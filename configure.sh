# Configurating the shell and themes
ln -s -f $PWD/zsh/.zshrc ~
ln -s -f $PWD/zsh/.oh-my-zsh ~
# zsh syntax highlighting
if [ ! -d zsh/.oh-my-zsh/plugins/zsh-syntax-highlighting ];then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ./zsh/.oh-my-zsh/plugins/zsh-syntax-highlighting
fi
if [ ! -d zsh/dracula ]; then
    git clone https://github.com/dracula/zsh.git ./zsh/dracula
fi
ln -s -f $PWD/zsh/dracula/dracula.zsh-theme ~/.oh-my-zsh/themes/dracula.zsh-theme
if [ ! -d ~/.config/nvim ]; then
    ln -s -f $PWD/vim ~/.config/nvim
fi
ln -s -f $PWD/tmux/.tmux/.tmux.conf ~
ln -s -f $PWD/.gitconfig ~
ln -s -f $PWD/python/.flake8 ~
ln -s -f $PWD/python/.pylintrc ~
ln -s -f $PWD/.ctags ~
#nvim +PlugInstall +qall
ln -s -f $PWD/tmux/tmuxinator.zsh ~/.tmuxinator.zsh

# Emacs config
ln -sf $PWD/emacs ~/.emacs.d
