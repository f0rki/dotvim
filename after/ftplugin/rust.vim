set textwidth=100
set shiftwidth=4
set softtabstop=4
set tabstop=4

let g:smart_display_opts = { 'column' : 101 }

if has("nvim")
    lua require('rust')
endif
