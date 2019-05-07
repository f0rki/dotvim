set textwidth=0
set shiftwidth=2
set softtabstop=2
set tabstop=2

autocmd BufWrite *.bib :call DeleteTrailingWS()

let g:smart_display_opts = { 'column' : 80 }
