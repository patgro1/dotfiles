" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.local/share/nvim/plugged')
Plug 'vhda/verilog_systemverilog.vim'
Plug 'scrooloose/nerdtree'
Plug 'dracula/vim',{'as':'dracula'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf'
Plug 'tpope/vim-commentary'
Plug 'christoomey/vim-tmux-navigator'
Plug 'geoffharcourt/vim-matchit'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
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
" "let g:syntastic_mode_map = {'mode': 'passive'}
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_filetype_map = { "verilog_systemverilog": "verilog" }
let g:syntyastic_verilog_checkers = ['verilator']
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

" CoC Configuration
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)
