mkdir -p ~/.config/nvim/
ln -s -f $PWD/init.vim ~/.config/nvim
ln -s -f $PWD/.zshrc ~
ln -s -f $PWD/.oh-my-zsh ~
ln -s -f $PWD/.tmux/.tmux.conf ~
ln -s -f $PWD/.flake8 ~
ln -s -f $PWD/.pylintrc ~
ln -s -f $PWD/.ctags ~
nvim +PlugInstall +qall
ln -s -f $PWD/tmuxinator.zsh ~/.tmuxinator.zsh
ln -s -f $PWD/tabular_extra.vim ~/.local/share/nvim/plugged/tabular/after/plugin/tabular_extra.vim
