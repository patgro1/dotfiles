mkdir -p ~/.config/nvim/
ln -s -f $PWD/init.vim ~/.config/nvim
ln -s -f $PWD/.zshrc ~
ln -s -f $PWD/.oh-my-zsh ~
ln -s -f $PWD/.tmux/.tmux.conf ~
ln -s -f $PWD/.flake8 ~
ln -s -f $PWD/.pylintrc ~
nvim +PlugInstall +qall
