# Configurating the shell and themes
if [ ! -d zsh/prezto ]; then
    git clone --recursive https://github.com/sorin-ionescu/prezto.git zsh/prezto
    ln -sf $PWD/zsh/prezto ~/.zprezto
    ln -sf $PWD/zsh/zshlogin ~/.zlogin
    ln -sf $PWD/zsh/zshlogout ~/.zlogout
    ln -sf $PWD/zsh/zpreztorc ~/.zpreztorc
    ln -sf $PWD/zsh/zprofile ~/.zprofile
    ln -sf $PWD/zsh/zshenc ~/.zshenv
    ln -sf $PWD/zsh/zshrc ~/.zshrc
fi
# Add the prexzto contrib repo
if [ ! -d zsh/prezto/contrib ]; then
    git clone --recurse-submodules https://github.com/belak/prezto-contrib zsh/prezto/contrib
fi

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
#if [ ! -L ~/.emacs.d ]; then
#    ln -sf $PWD/emacs ~/.emacs.d
#fi
# Install Doom Emacs
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Installing emacs-plus"
    brew install emacs-plus --with-ctags 
fi
if [ ! -L ~/.emacs.d ]; then
    git clone https://github.com/hlissner/doom-emacs ~/.emacs.d
fi
ln -s -f $PWD/.doom.d ~
~/.emacs.d/bin/doom refresh

