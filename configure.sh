# Configurating the shell and themes
ln -s -f $PWD/.zshrc ~
ln -s -f $PWD/.oh-my-zsh ~
# zsh syntax highlighting
if [ ! -d zsh-syntax-highlighting ];then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
fi
ln -s -f $PWD/zsh-syntax-highlighting $PWD/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
if [ ! -d ./dracula ]; then
    mkdir -p dracula
fi
cd dracula
if [ ! -d zsh ]; then
    git clone https://github.com/dracula/zsh.git
fi
ln -s -f $PWD/zsh/dracula.zsh-theme ~/.oh-my-zsh/themes/dracula.zsh-theme
cd ../
mkdir -p ~/.config/nvim/
ln -s -f $PWD/init.vim ~/.config/nvim
ln -s -f $PWD/vimrc/ ~/.config/nvim/vimrc
ln -s -f $PWD/.tmux/.tmux.conf ~
ln -s -f $PWD/.gitconfig ~
ln -s -f $PWD/.flake8 ~
ln -s -f $PWD/.pylintrc ~
ln -s -f $PWD/.ctags ~
nvim +PlugInstall +qall
ln -s -f $PWD/tmuxinator.zsh ~/.tmuxinator.zsh
ln -s -f $PWD/tabular_extra.vim ~/.local/share/nvim/plugged/tabular/after/plugin/tabular_extra.vim
