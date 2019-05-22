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
Plug 'tpope/vim-commentary'
Plug 'christoomey/vim-tmux-navigator'
Plug 'geoffharcourt/vim-matchit'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-rhubarb'
Plug 'godlygeek/tabular'
Plug 'iamcco/markdown-preview.nvim', { 'do': ':call mkdp#util#install()', 'for': 'markdown', 'on': 'MarkdownPreview' }
Plug 'posva/vim-vue'

call plug#end()

filetype plugin indent on    " required
filetype plugin on

" Airline configuration
let g:airline_power_line_fonts=1
let g:airline#extensions#syntastic#enabled=1
set t_Co=256
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#fnamemode=':t'
let g:airline_theme='simple'

nnoremap <F6> :NERDTreeToggle<CR>

" Syntastic configuration
let g:syntastic_mode_map = {'mode': 'passive'}
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
nmap <F10> :SyntasticCheck<CR>
nmap <F11> :SyntasticReset<CR>

" Markdown-preview config
"
let g:mkdp_page_title = '「${name}」'

"FZF to control-p
nmap <c-p> :FZF<cr>
" When FZF is open, esc force it to close
autocmd! FileType fzf tnoremap <buffer> <esc> <c-c>

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

" Fugitive mapping
let g:github_enterprise_urls = ['https://git.drwholdings.com']
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gbb :.Gbrowse<CR>
vnoremap <Leader>gbb :Gbrowse<CR>
nnoremap <Leader>gaf :Gw<CR>
nnoremap <Leader>gst :Git! stash<CR>
nnoremap <Leader>gsa :Git! stash apply<CR>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>gl :0Glog<CR>
nnoremap <Leader>gd :Gdiff<CR>
set diffopt+=vertical


" Tmux nav
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-\> :TmuxNavigatePrevious<cr>

" Gitgutter configuration
"
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '>'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = '<'

" Hunk navigation
nmap <Leader>gn <Plug>GitGutterNextHunk
nmap <Leader>gp <Plug>GitGutterNextHunk
" Hunk staging
nmap <Leader>ga <Plug>GitGutterStageHunk
nmap <Leader>gu <Plug>GitGutterUndoHunk


