set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'vhda/verilog_systemverilog.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'morhetz/gruvbox'
Plugin 'vim-airline/vim-airline'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-syntastic/syntastic'
Plugin 'junegunn/fzf'
Plugin 'davidhalter/jedi-vim'
Plugin 'christoomey/vim-tmux-navigator'
Bundle 'geoffharcourt/vim-matchit'
Bundle 'Glench/Vim-Jinja2-Syntax'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
filetype plugin on
set guicursor=
set background=dark
colorscheme gruvbox
let g:gruvbox_termcolors=256
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

syntax enable "enable syntax processing

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab "tabs are spaces

set number
set showcmd
let ftToIgnore = ['systemverilog']
autocmd BufNewFile,BufRead * if index(ftToIgnore, &ft) < 0 | set cursorline
autocmd BufNewFile,BufRead * if index(ftToIgnore, &ft) < 0 | set colorcolumn=120

filetype indent on

set wildmenu
set lazyredraw
set showmatch

set incsearch
set hlsearch

set foldenable
set foldlevelstart=10

" Syntastic configuration
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

let g:airline_power_line_fonts = 1
let g:airline#extensions#syntastic#enabled = 1
" let g:airline_theme='luna'
set t_Co=256

" Buffer management
set hidden
" Change the leader key to space
let mapleader = " "
" Open a new buffer
nmap <leader>T :enew<CR>
" Next buffer
nmap <leader>l :bnext<CR>
" Previous buffer
nmap <leader>p :bprevious<CR>
"Close current buffer and got to previous one
nmap <leader>bq :bp <BAR> bd #<CR>
" List of all buffers
nmap <leader>bl :ls<CR>

nnoremap <leader>, :noh<CR>
nnoremap <F6> :NERDTreeToggle<CR>

" Enable airline buffer list
let g:airline#extensions#tabline#enabled = 1
" Show only the file name
let g:airline#extensions#tabline#fnamemode = ':t'

let g:syntastic_mode_map = {'mode': 'passive'}
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
nmap <F7> :SyntasticCheck<CR>
nmap <F8> :SyntasticReset<CR>

nmap <c-p> = :FZF<cr>

" Matchit configuration for system verilog
source ~/.vim/bundle/vim-matchit/plugin/matchit.vim
if exists('loaded_matchit')
        let b:match_ignorecase=0
        let b:match_words=
          \ '\<begin\>:\<end\>,' .
          \ '\<if\>:\<else\>,' .
          \ '\<module\>:\<endmodule\>,' .
          \ '\<class\>:\<endclass\>,' .
          \ '\<program\>:\<endprogram\>,' .
          \ '\<clocking\>:\<endclocking\>,' .
          \ '\<property\>:\<endproperty\>,' .
          \ '\<sequence\>:\<endsequence\>,' .
          \ '\<package\>:\<endpackage\>,' .
          \ '\<covergroup\>:\<endgroup\>,' .
          \ '\<primitive\>:\<endprimitive\>,' .
          \ '\<specify\>:\<endspecify\>,' .
          \ '\<generate\>:\<endgenerate\>,' .
          \ '\<interface\>:\<endinterface\>,' .
          \ '\<function\>:\<endfunction\>,' .
          \ '\<task\>:\<endtask\>,' .
          \ '\<case\>\|\<casex\>\|\<casez\>:\<endcase\>,' .
          \ '\<fork\>:\<join\>\|\<join_any\>\|\<join_none\>,' .
          \ '`ifdef\>:`else\>:`endif\>,'
endif

let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-\> :TmuxNavigatePrevious<cr>

"Making make_* be seen as a makefile
autocmd BufRead,BufNewFile make_* set filetype=make

