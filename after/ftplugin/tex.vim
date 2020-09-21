set textwidth=0
set shiftwidth=2
set tabstop=2

" we're going for the one-sentence per-line formatting
set formatexpr=FormatOneSentencePerLine(v:lnum,v:lnum+v:count-1)

"setlocal formatoptions=ant
"setlocal wrapmargin=0

"autocmd BufWrite *.tex :call DeleteTrailingWS()
" enable spell checking for tex document
syntax spell toplevel
set spell
" enable conceal for concealing math mode with unicode chars
" set conceallevel=1
" hi clear Conceal

" enable vimtex for deoplete
call deoplete#custom#var('omni', 'input_patterns', {
      \ 'tex': g:vimtex#re#deoplete
      \})

"is this needed? no, I guess?
"let g:vimtex_complete_enabled = 1

nmap <leader>T :VimtexTocToggle<CR>
nmap <leader>R :VimtexCompile<CR>
nmap <leader>V :VimtexView<CR>

au User VimtexEventQuit     VimtexClean

"let g:vimtex_view_enable = 1
let g:vimtex_quickfix_mode = '2'

" zathura is awesome but doesn't work so nicely with synctex
let g:vimtex_view_method = "zathura"

" okular seems to work fine though
"let g:vimtex_view_method = "general"
"let g:vimtex_view_general_viewer = 'okular'
"let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
"let g:vimtex_view_general_options_latexmk = '--unique'


" configure ALE fixers
let b:ale_fixers = ['trim_whitespace', 'remove_trailing_lines', 'latexindent']
" and the ALE linters...
let b:ale_linters = ['lacheck', 'vale', 'textidote', 'texlab']

let g:smart_display_opts = { 'column' : 0 }
