ln -s -f $PWD/.vim ~
ln -s -f $PWD/.vimrc ~
ln -s -f $PWD/.zshrc ~
ln -s -f $PWD/.oh-my-zsh ~
ln -s -f $PWD/.tmux/.tmux.conf ~
ln -s -f $PWD/.flake8 ~
ln -s -f $PWD/.pylintrc ~
vim +PluginInstall +qall
