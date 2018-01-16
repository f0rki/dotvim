set textwidth=100
set shiftwidth=4
set softtabstop=4
set tabstop=4

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" from: https://github.com/rust-lang/rust.vim/issues/97#issuecomment-250273084
"
" create our actual neomake maker for cargo. Note that neomake ships with a
" default maker, but it is not using the new error format which resides in
" nightly.
"
" I'm using an explicit 'cargo' exe name incase i want to change the maker
" name without affecting the binary. `append_file` is used because neomake
" will automatically append the file path to the end of the full command,
" which causes cargo to fail. Finally, the errorformat was pulled from
" a rust.vim PR[1] attempting to fix the problem that causes me to add
" this whole neomake maker. Thanks to them!!
"
" [1]: https://github.com/rust-lang/rust.vim/pull/99#issuecomment-244954595
let g:neomake_rust_cargo_maker = {
            \ 'exe': 'cargo',
            \ 'args': ['build'],
            \ 'append_file': 0,
            \ 'errorformat': '%Eerror%m,%Z\ %#-->\ %f:%l:%c',
            \ }
" Replace the default makers list with our new maker, ensuring our cargo maker
" and not the default maker is what is run when we save.
let g:neomake_rust_enabled_makers = ['cargo']
" Automatically run this maker when we save .rs files.
autocmd! BufWritePost *.rs Neomake cargo
"
"let g:rustfmt_fail_silently=1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:smart_display_opts = { 'column' : 101 }
