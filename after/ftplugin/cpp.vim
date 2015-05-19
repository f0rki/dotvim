"set noexpandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

" delete trailing whitespaces on write
autocmd BufWrite *.cpp :call DeleteTrailingWS()
autocmd BufWrite *.cxx :call DeleteTrailingWS()
autocmd BufWrite *.cc :call DeleteTrailingWS()

autocmd BufWrite *.h :call DeleteTrailingWS()
autocmd BufWrite *.hpp :call DeleteTrailingWS()
