let mapleader = " "
source $HOME/.config/nvim/vimrc/plug.vim
syntax enable "enable syntax processing

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

set number
set relativenumber

" This set on and off the relative number if the window has focus or not
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END
