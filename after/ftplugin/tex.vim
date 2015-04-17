set cc=0

autocmd BufWrite *.tex :call DeleteTrailingWS()
" enable spell checking for tex document
syntax spell toplevel
set spell
" enable conceal for nice math mode display
set conceallevel 1
