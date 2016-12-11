""""""""""""""""""""""""""""""
" => Python section
""""""""""""""""""""""""""""""
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=8

" delete trailing whitespaces on write
autocmd BufWrite *.py :call DeleteTrailingWS()

let g:autopep8_max_line_length=79
let g:autopep8_disable_show_diff=1
"autocmd BufWrite *.py :call Autopep8()
"autocmd BufWritePost *.py call Flake8()
map <buffer> <F4> :call Autopep8()<CR>
map <buffer> <F3> :call Flake8()<CR>

let g:flake8_show_in_gutter=1  " show
let g:flake8_show_in_file=1  " show

"let g:pymode = 1
"let g:pymode_folding = 0
"let g:pymode_motion = 0
"let g:pymode_options_colorcolumn = 0
"let g:pymode_virtualenv = 1
"let g:pymode_lint_on_write = 1
"let g:pymode_lint_checkers = ['pyflakes', 'pep8', 'mccabe']

au FileType python set nocindent
let python_highlight_all = 1
au FileType python syn keyword pythonDecorator True None False self
