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

if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
endif
"let g:ycm_semantic_triggers.tex = [
"    \ 're!\\[A-Za-z]*cite[A-Za-z]*(\[[^]]*\]){0,2}{[^}]*',
"    \ 're!\\[A-Za-z]*ref({[^}]*|range{([^,{}]*(}{)?))',
"    \ 're!\\hyperref\[[^]]*',
"    \ 're!\\includegraphics\*?(\[[^]]*\]){0,2}{[^}]*',
"    \ 're!\\(include(only)?|input){[^}]*',
"    \ 're!\\\a*(gls|Gls|GLS)(pl)?\a*(\s*\[[^]]*\]){0,2}\s*\{[^}]*',
"    \ 're!\\includepdf(\s*\[[^]]*\])?\s*\{[^}]*',
"    \ 're!\\includestandalone(\s*\[[^]]*\])?\s*\{[^}]*',
"    \ ]

"let g:ycm_semantic_triggers.tex = g:vimtex#re#youcompleteme


nmap <leader>T :VimtexTocToggle<CR>
nmap <leader>R :VimtexCompile<CR>
nmap <leader>V :VimtexView<CR>

au User VimtexEventQuit     VimtexClean

"let g:vimtex_view_enable = 1
let g:vimtex_quickfix_mode = '2'

"let g:vimtex_view_method = "zathura"

let g:vimtex_view_method = "general"
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'


let g:smart_display_opts = { 'column' : 101 }
