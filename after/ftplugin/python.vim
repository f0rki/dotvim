""""""""""""""""""""""""""""""
" => Python section
""""""""""""""""""""""""""""""
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=8

" delete trailing whitespaces on write
autocmd BufWrite *.py :call DeleteTrailingWS()

au FileType python set nocindent
let python_highlight_all = 1
au FileType python syn keyword pythonDecorator True None False self



