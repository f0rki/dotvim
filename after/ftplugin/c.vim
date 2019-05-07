"set noexpandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

" delete trailing whitespaces on write
"autocmd BufWrite *.c :call DeleteTrailingWS()
"autocmd BufWrite *.h :call DeleteTrailingWS()
" set colorcolumn=100

"let b:ale_linters = ['cargo', 'rls', 'rustc']
let b:ale_fixers = ['trim_whitespace', 'remove_trailing_lines', 'clang-format']
let b:ale_fix_on_save = 1

if executable('clangd')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd']},
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
        \ })
endif
