# Configurating the shell and themes
if [ ! -d zsh/prezto ]; then
    git clone --recursive https://github.com/sorin-ionescu/prezto.git zsh/prezto
fi
ln -sf $PWD/zsh/prezto ~/.zprezto
ln -sf $PWD/zsh/zshlogin ~/.zlogin
ln -sf $PWD/zsh/zshlogout ~/.zlogout
ln -sf $PWD/zsh/zpreztorc ~/.zpreztorc
ln -sf $PWD/zsh/zprofile ~/.zprofile
ln -sf $PWD/zsh/zshenc ~/.zshenv
ln -sf $PWD/zsh/zshrc ~/.zshrc
# zsh syntax highlighting
# if [ ! -d zsh/.oh-my-zsh/plugins/zsh-syntax-highlighting ];then
#     git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ./zsh/.oh-my-zsh/plugins/zsh-syntax-highlighting
# fi
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
