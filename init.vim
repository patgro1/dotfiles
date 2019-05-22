source $HOME/.config/nvim/vimrc/plug.vim
syntax enable "enable syntax processing
let mapleader = " "

source $HOME/.config/nvim/vimrc/display.vim
source $HOME/.config/nvim/vimrc/alias.vim
source $HOME/.config/nvim/vimrc/languages.vim

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab "tabs are spaces

filetype indent on

set updatetime=250
set wildmenu
set lazyredraw
set showmatch
set incsearch
set hlsearch

set foldenable
set foldlevelstart=10
set noswapfile
