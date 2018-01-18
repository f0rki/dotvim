set textwidth=100
set tabstop=4
set shiftwidth=4
set softtabstop=0
set noexpandtab

autocmd BufWrite *.go :call DeleteTrailingWS()

let g:smart_display_opts = { 'column' : 101 }
