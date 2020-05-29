""""""""""""""""""""""""""""""
" => Python section
""""""""""""""""""""""""""""""
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=8

set textwidth=0

au FileType python set nocindent
let python_highlight_all = 1
au FileType python syn keyword pythonDecorator True None False self

"let b:ale_linters = ['flake8', 'mypy', 'pylint', 'vulture', 'bandit']
"let b:ale_linters = ['pylint', 'mypy']
"let b:ale_linters = ['prospector', 'pylint', 'mypy', 'bandit']
let b:ale_linters = ['mypy', 'bandit', 'prospector']
let b:ale_fixers = ['trim_whitespace', 'isort', 'yapf']
" we don't want it automatically, as yapf can f* up the source code if there is
" a syntax error...
let b:ale_fix_on_save = 0

let g:ale_python_auto_pipenv = 1
let g:ale_python_mypy_auto_pipenv = 1
let g:ale_python_mypy_options = '--ignore-missing-imports'
