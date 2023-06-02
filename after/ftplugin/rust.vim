set textwidth=100
set shiftwidth=4
set softtabstop=4
set tabstop=4

" rustc does only seem to work with the nightly?
"let b:ale_linters = ['rls', 'cargo', 'rustc']
let b:ale_linters = []
let b:ale_fixers = ['trim_whitespace', 'remove_trailing_lines', 'rustfmt']
let b:ale_fix_on_save = 0

let g:smart_display_opts = { 'column' : 101 }

"let b:ale_lint_on_insert_leave = 1
"let g:ale_rust_cargo_use_clippy = 1

" let g:ale_rust_analyzer_executable = 'rustup run nightly rust-analyzer'

let b:ale_rust_rls_config = {
      \   'rust': {
      \     'clippy_preference': 'on'
      \   }
      \ }
