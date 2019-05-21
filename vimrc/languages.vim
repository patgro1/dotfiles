let ftToIgnore = ['systemverilog']
autocmd BufNewFile,BufRead * if index(ftToIgnore, &ft) < 0 | set cursorline
autocmd BufNewFile,BufRead * if index(ftToIgnore, &ft) < 0 | set colorcolumn=120

"Making make_* be seen as a makefile
autocmd BufRead,BufNewFile make_* set filetype=make
