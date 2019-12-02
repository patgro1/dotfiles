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

" Terminal mode mapping
:tnoremap <Esc> <C-\><C-n>
