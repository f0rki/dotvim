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

function! s:bibtex_cite_sink_insert(lines)
    let r=system("bibtex-cite -separator=', ' -prefix='' -postfix='' ", a:lines)
    execute ':normal! i' . r
    call feedkeys('a', 'n')
endfunction

function! s:bibtex_cite_sink(lines)
    let r=system("bibtex-cite -mode=latex ", a:lines)
    execute ':normal! i' . r
endfunction


inoremap <silent> @@ <c-g>u<c-o>:call fzf#run({
                        \ 'source': Bibtex_ls(),
                        \ 'sink*': function('<sid>bibtex_cite_sink_insert'),
                        \ 'up': '40%',
                        \ 'options': '--ansi --layout=reverse-list --multi --prompt "Cite> "'})<CR>

nnoremap <silent> <leader>C :call fzf#run({
                        \ 'source': Bibtex_ls(),
                        \ 'sink*': function('<sid>bibtex_cite_sink'),
                        \ 'up': '40%',
                        \ 'options': '--ansi --layout=reverse-list --multi --prompt "Cite> "'})<CR>


function! s:bibtex_markdown_sink(lines)
    let r=system("bibtex-markdown ", a:lines)
    execute ':normal! i' . r
endfunction

" nnoremap <silent> <leader>M :call fzf#run({
"                         \ 'source': Bibtex_ls(),
"                         \ 'sink*': function('<sid>bibtex_markdown_sink'),
"                         \ 'up': '40%',
"                         \ 'options': '--ansi --layout=reverse-list --multi --prompt "Markdown> "'})<CR>


function Latex_label_join(line)
    let parts = split(a:line, ':')
    call remove(parts, 0, 1)
    execute ':normal! i' . join(parts, ':')
endfunction

inoremap <silent> @c <c-g>u<c-o>:call fzf#run({
                        \ 'source': "rg --color always -n 'label\\{(.+)\\}' -o -r '$1'",
                        \ 'sink': function('Latex_label_join'),
                        \ 'up': '40%',
                        \ 'options': '--ansi --layout=reverse-list --multi --prompt "Label> "'})<CR>




au User VimtexEventQuit     VimtexClean

"let g:vimtex_view_enable = 1
let g:vimtex_quickfix_mode = '2'

" zathura is awesome but doesn't work so nicely with synctex
"let g:vimtex_view_method = "zathura"

" okular seems to work fine though
let g:vimtex_view_method = "general"
" let g:vimtex_view_general_viewer = 'okular'
" let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'


" configure ALE fixers
let b:ale_fixers = ['trim_whitespace', 'remove_trailing_lines', 'latexindent']
" and the ALE linters...
let b:ale_linters = ['lacheck', 'vale', 'textidote']

let g:smart_display_opts = { 'column' : 0 }

" let g:ale_tex_ltex_options = "--log-file=./ltex.log"
" let g:ale_tex_ltex_config = {'checkFrequency': 'edit', 'additionalRules': {'enablePickyRules': 1, 'motherTongue': 'de-DE'}, 'enabled': ['tex', 'latex', 'bibtex'], "additionalRules.word2VecModel": "~/.lt_data/word2vec/", "additionalRules.languageModel": "~/.lt_data/ngram/", "ltex-ls" :{ "logLevel": "finest"}, "trace": {"server": "verbose"}, "language": "en-US"}
