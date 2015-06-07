set textwidth=99
set shiftwidth=2
set softtabstop=2
set tabstop=2

autocmd BufWrite *.c :call DeleteTrailingWS()
autocmd BufWrite *.cpp :call DeleteTrailingWS()
autocmd BufWrite *.cc :call DeleteTrailingWS()
autocmd BufWrite *.cxx :call DeleteTrailingWS()
autocmd BufWrite *.h :call DeleteTrailingWS()
autocmd BufWrite *.hpp :call DeleteTrailingWS()

let g:smart_display_opts = { 'column' : 100 }
