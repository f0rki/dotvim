"set noexpandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

"let b:ale_linters = ['clangd', 'clangcheck', 'cppcheck', 'flawfinder']
" let b:ale_fixers = ['nixpkgs-fmt']
let b:ale_fixers = ['alejandra']
let b:ale_fix_on_save = 1
