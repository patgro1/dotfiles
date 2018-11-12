" Tabular shortcuts
:AddTabularPattern! module_inst /\.\w*\s*([A-Za-z0-9'_"]*\s*\zs
nmap <leader>tp :Tabularize /(/l0<cr>:Tabularize module_inst<CR>
vmap <leader>tp :Tabularize /(/l0<cr>gv:Tabularize module_inst<CR>
:AddTabularPattern! module_id /\(input\|output\|parameter\)\s*[A-Z0-9a-z:_]*\s*\(\[\s*[a-zA-Z_\-:0-9]*\]\s*\)\=\zs\s*\w*
nnoremap <leader>m :Tabularize module_id<CR>:Tabularize /,<CR>
vnoremap <leader>m :Tabularize module_id<CR>gv:Tabularize /,<CR>
