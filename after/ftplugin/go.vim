set textwidth=100
set tabstop=4
set shiftwidth=4
set softtabstop=0
set noexpandtab

autocmd BufWrite *.go :call DeleteTrailingWS()

let g:smart_display_opts = { 'column' : 0 }

"let b:ale_linters = []
let b:ale_fixers = ['gofmt', 'goimports']
let b:ale_fix_on_save = 1

" for ncm2-lsp
if executable('go-langserver')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'go-langserver',
        \ 'cmd': {server_info->['go-langserver', '-gocodecompletion']},
        \ 'whitelist': ['go'],
        \ })
endif
