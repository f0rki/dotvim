set textwidth=80
set shiftwidth=2
set softtabstop=2
set tabstop=2

autocmd BufWrite *.js :call DeleteTrailingWS()

let g:smart_display_opts = { 'column' : 101 }
"let b:ale_linters = []
let b:ale_fixers = ['trim_whitespace', 'prettier']
