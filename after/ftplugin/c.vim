set noexpandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

" delete trailing whitespaces on write
autocmd BufWrite *.c :call DeleteTrailingWS()
autocmd BufWrite *.h :call DeleteTrailingWS()
set colorcolumn=100
