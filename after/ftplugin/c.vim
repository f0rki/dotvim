"set noexpandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

let b:ale_linters = ['clangcheck', 'cppcheck', 'flawfinder']
let b:ale_fixers = ['trim_whitespace', 'remove_trailing_lines', 'clang-format']
"let b:ale_fix_on_save = 1
let g:ale_c_parse_compile_commands = 1
