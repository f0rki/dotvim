"set noexpandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

" delete trailing whitespaces on write
autocmd BufWrite *.c :call DeleteTrailingWS()
autocmd BufWrite *.h :call DeleteTrailingWS()
set colorcolumn=100
