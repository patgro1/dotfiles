" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.local/share/nvim/plugged')
Plug 'vhda/verilog_systemverilog.vim'
Plug 'scrooloose/nerdtree'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-syntastic/syntastic'
Plug 'junegunn/fzf'
Plug 'davidhalter/jedi-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'geoffharcourt/vim-matchit'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter' 
Plug 'godlygeek/tabular'

call plug#end()

filetype plugin indent on    " required
filetype plugin on
set guicursor=
set background=dark
colorscheme gruvbox
let g:gruvbox_termcolors=256

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

let g:airline_power_line_fonts=1
let g:airline#extensions#syntastic#enabled=1
set t_Co=256

" New leader is space
let mapleader = " "
" Buffer management
set hidden
nmap <leader>T :enew<cr>
nmap <leader>l :bnext<cr>
nmap <leader>p :bprevious<cr>
nmap <leader>q :bp <BAR> bd #<CR>
nmap <leader>bl :ls<CR>

" Clear all search highlights
nnoremap <leader>, :noh<CR>
nnoremap <leader>nt :NERDTreeToggle<CR>

let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#fnamemode=':t'
let g:airline_theme='simple'

" Syntastic configuration
let g:syntastic_mode_map = {'mode': 'passive'}
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
nmap <F10> :SyntasticCheck<CR>
nmap <F11> :SyntasticReset<CR>

"FZF to control-p
nmap <c-p> :FZF<cr>

" Matchit config for systemverilog
" TODO: Make sure that works now
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

" Terminal mode mapping
:tnoremap <Esc> <C-\><C-n>

let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-\> :TmuxNavigatePrevious<cr>

"Making make_* be seen as a makefile
autocmd BufRead,BufNewFile make_* set filetype=make

" Git gutter
nmap <leader>gh :GitGutterLineHighlightsToggle<cr>

" Tabular shortcuts
:AddTabularPattern! module_inst /\.\w*\s*([A-Za-z0-9'_"]*\s*\zs
nmap <leader>tp :Tabularize /(/l0<cr>:Tabularize module_inst<CR>
vmap <leader>tp :Tabularize /(/l0<cr>gv:Tabularize module_inst<CR>
:AddTabularPattern! module_id /\(input\|output\|parameter\)\s*[A-Z0-9a-z:_]*\s*\(\[\s*[a-zA-Z_\-:0-9]*\]\s*\)\=\zs\s*\w*
nnoremap <leader>m :Tabularize module_id<CR>:Tabularize /,<CR>
vnoremap <leader>m :Tabularize module_id<CR>gv:Tabularize /,<CR>
