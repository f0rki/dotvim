set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=8

" delete trailing whitespaces on write
autocmd BufWrite *.coffee :call DeleteTrailingWS()
