set textwidth=0
set shiftwidth=2
set softtabstop=2
set tabstop=2

"autocmd BufWrite *.bib :call DeleteTrailingWS()

" configure ALE fixers
let b:ale_fixers = ['trim_whitespace', 'remove_trailing_lines', 'bibclean']
" and the ALE linters...
let b:ale_linters = ['bibclean']


let g:smart_display_opts = { 'column' : 80 }
