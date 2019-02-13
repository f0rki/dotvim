set textwidth=100
set shiftwidth=4
set softtabstop=4
set tabstop=4

let b:ale_linters = ['cargo', 'rls', 'rustc']
let b:ale_fixers = ['rustfmt', 'trim_whitespace', 'remove_trailing_lines']
let b:ale_fix_on_save = 1

let g:smart_display_opts = { 'column' : 101 }

" for ncm2-lsp
if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'Cargo.toml'))},
        \ 'whitelist': ['rust'],
        \ })
endif
