set textwidth=79
set shiftwidth=2
set tabstop=2

autocmd BufWrite *.tex :call DeleteTrailingWS()
" enable spell checking for tex document
syntax spell toplevel
set spell
" enable conceal for concealing math mode with unicode chars
" set conceallevel=1
" hi clear Conceal
"
