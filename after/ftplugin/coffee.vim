set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=8

set colorcolumn=80

" delete trailing whitespaces on write
autocmd BufWrite *.coffee :call DeleteTrailingWS()
