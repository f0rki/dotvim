set textwidth=0
set shiftwidth=2
set softtabstop=2
set tabstop=2

let g:smart_display_opts = { 'column' : 0 }

let b:ale_fixers = ['trim_whitespace', 'remove_trailing_lines', 'dprint']
let b:ale_linters = ['jq']
" let b:ale_fix_on_save = 1
