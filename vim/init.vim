" Using space a is leader is really convenient.
let mapleader = " "

" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.local/share/nvim/plugged')
Plug 'preservim/nerdtree' " File explorer
Plug 'morhetz/gruvbox'
Plug 'Yggdroot/indentLine' " Show indentation line
Plug 'vim-airline/vim-airline' " Better status line
Plug 'tpope/vim-fugitive' " Git wrapper
Plug 'airblade/vim-gitgutter' " Sign in line number colums for git changes
Plug 'liuchengxu/vim-which-key' "Which key helpers
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'jmcantrell/vim-virtualenv'
Plug 'vhda/verilog_systemverilog.vim'
Plug 'frazrepo/vim-rainbow'
call plug#end()

"""""""""""""""""""""""""""""""
" TAB and Indentation
"""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab
" Be smart
set smarttab
" Indentation is 4 spaces
set shiftwidth=4
set tabstop=4
" Linebreak on 500 characters
set lbr
set tw=500

set autoindent
set smartindent
set wrap

" Clear search highlight
nnoremap <leader>, :noh<cr>

"""""""""""""""""""""""""""""""
" Open the current config file
"""""""""""""""""""""""""""""""
nnoremap <leader>fp :e $MYVIMRC<CR>

"""""""""""""""""""""""""""""""
" Enables whichkey
"""""""""""""""""""""""""""""""
call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

"""""""""""""""""""""""""""""""
" Visuals of the editor
"""""""""""""""""""""""""""""""
" Color scheme setup
set termguicolors
colorscheme gruvbox
" Show line numbers
set number
" Setting relative number
set relativenumber
" This function toggles the relative number on and off
function! ToggleRelativeLineNumbers()
    if &relativenumber
        set norelativenumber
    else
        set relativenumber
    endif
endfunction
function! ToggleLineNumbers()
    if &number
        set nonumber
    else
        set number
    endif
endfunction

" Mapping to toggle the relative line number of needed
nnoremap <Leader>lr :call ToggleRelativeLineNumbers()<CR>
nnoremap <Leader>lt :call ToggleLineNumbers()<CR>
" Configure the indentLine
let g:indenLine_setColors = 0 "Make sure we use the colorscheme colors

"""""""""""""""""""""""""""""""
" Movements
"""""""""""""""""""""""""""""""
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"""""""""""""""""""""""""""""""
" Buffer management
"""""""""""""""""""""""""""""""
" Destroy the current buffer
map <leader>bk :bdelete<cr>
" Open the switch buffer
map <leader>bb :Buffers<cr> 


" Toggle NERDTree
nnoremap <Leader>t :NERDTreeToggle<cr>

" Auto read on buffer switch
set autoread

" Enabling filetype plugins
filetype plugin on
filetype indent on

"""""""""""""""""""""""""""""""
" Git (fugitive)
"""""""""""""""""""""""""""""""
nnoremap <leader>gg :Gstatus<cr>


"""""""""""""""""""""""""""""""
" File management
"""""""""""""""""""""""""""""""
map <leader>ff :GFiles<cr>
map <leader>f. :Files<cr>


"""""""""""""""""""""""""""""""
" Custom filetype mapping
"""""""""""""""""""""""""""""""
au BufRead,BufNewFile make_* set filetype=make

"""""""""""""""""""""""""""""""
" Python specific
"""""""""""""""""""""""""""""""
let g:virtualenv_directory = '~/virtualenvs'


"""""""""""""""""""""""""""""""
" Whichkey tables
"""""""""""""""""""""""""""""""
let g:which_key_map = {}
""" Line numbers
let g:which_key_map.l = {
                        \ 'name': '+LineNumbers',
                        \ 'r': 'Toggle Relative Line Numbers',
                        \ 't': 'Toggle Line Numbers'}
""" File management
let g:which_key_map.f = {
                        \ 'name': '+Files',
                        \ '.': 'Open files',
                        \ 'f': 'Open files (git)',
                        \ 'p': 'Open init.vim'}
"""Buffer management
let g:which_key_map.b = {'name': '+Buffers'}
let g:which_key_map.b.b = 'Open'
let g:which_key_map.b.k = 'Kill'

"""""""""""""""""""""""""""""""
" Enable rainbow by default
"""""""""""""""""""""""""""""""
let g:rainbow_active=1
