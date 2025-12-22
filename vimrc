"""""""""""""""""""""""""""""""""""""""""
" f0rki's .vimrc
"
" Here is a quick overview of useful shortcuts

"""" buffer management
" ;d close the buffer
" ;f to open fuzzy finder for file list (honoring gitignore if within a repo)
" ;t to open fuzzy file list (without gitignore)
" ;b to open fuzzy list of open buffers
"

"""" movement
" f<char> to jump to <char> on line (F for backward)
" 0 go to frist non-blank char in line
" ^ go to actual line start
" $ to line end
" jumplist navigation with C-i and C-o

"""" git
"
" jump between hunks with: [c and ]c
" stage, unstate with ;hs and ;hu
" preview hunk diff ;hp
"
" :G to view git index and as git cli shortcut
"   Use '+' and '-' keys to add and remove files from index
"   (i.e., git add and git reset)
"   Use '=' to show the diff (very nice)
"
" (hint the following can ommit the whitespace)
" :G diff :Gdiffsplit
" :G blame
" :G commit
" :G push
" etc.
"

""" todo.txt editing
" 's - sort by prio
" 'sdd - sort by due date
" 's+ - sort by project
" 'j/k - inc/decrease prio
" '(a|b|c) - set prio
" 'x - mark as done

""" vimtex / latex editing
" ;R start continous compilation
" ;V view pdf / synctex forward search (if already open)
" ;C search and insert for bibtex citation
" @@ inline bibtex citation key insert


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" we need this when using fish, or otherwise some plugins are fubar
set shell=/bin/sh
" disable vi compat
set nocompatible
" we want line numbers
set number
" Sets how many lines of history VIM has to remember
set history=4096
" Set to auto read when a file is changed from the outside
set autoread
" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
" TODO: consider alternative leader
let mapleader = ";"
let maplocalleader = "'"
let g:mapleader = ";"
let g:localleader = "'"
" Ignore case when searching
set ignorecase
" When searching try to be smart about cases
set smartcase
" Highlight search results
set hlsearch
" Makes search act like search in modern browsers
set incsearch
" Don't redraw while executing macros (good performance config)
set lazyredraw
" For regular expressions turn magic on
set magic
" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2
" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

set title
set wildignore=*.swp,*.bak,*.pyc,*.class
set wildignore+=*.aux,*toc,*blg,*.bcf,*bbl,*.tdo
set wildignore+=*.bin,*.so,*.rlib
set wildignore+=*_build/*
set wildignore+=*build/*
set wildignore+=*/coverage/*

" let tab trigger auto completion
set wildchar=<Tab> wildmenu wildmode=full

if has('mouse')
    set mouse=a
endif

" workaround for neovim in alacritty: https://github.com/neovim/neovim/issues/11330
if has('nvim')
    "autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID"
endif



"""""""""""""""""""""""""""""""""""""""""
" plugins
"""""""""""""""""""""""""""""""""""""""""

if has('nvim')
    " use lazy to load plugins
    lua require('config.lazy')

    " golang vim plugin loaded from system
    " TODO: is this still needed?
    if file_readable(expand("$GOROOT/misc/vim/"))
        set rtp+=$GOROOT/misc/vim
    elseif file_readable(expand("/usr/share/go/misc/vim/"))
        set rtp+=/usr/share/go/misc/vim/
    endif
end


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable syntax highlighting
syntax enable

if has("nvim")
    set termguicolors
    let g:material_style = 'darker'
    " colorscheme material
    "colorscheme github_dark_default
    "colorscheme onedark
    colorscheme kanagawa-wave
endif

if has("nvim") || has("gui_running")
    " copypasta from X clipboard
    nmap <leader>P "+gP
    nmap <leader>Y "+yy
    vmap <leader>Y "+y
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile
" However, we still want persistent undo
set undodir=$HOME/.vim_undo/
set undofile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

set lbr
set textwidth=79

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" easy auto indentation
vmap Q gq
nmap Q gqap

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Move across wrapped lines like regular lines
" Go to the first non-blank character of a line
noremap 0 g^
" Just in case you need to go to the very beginning of a line
noremap ^ g0
noremap $ g$

" smart moving around wrapped lines
nnoremap <expr> j (v:count > 4 ? "m'" . v:count . 'j' : 'gj')
nnoremap <expr> k (v:count > 4 ? "m'" . v:count . 'k' : 'gk')

" jumplist navigation without pressing shift...
map <C-i> <C-I>
map <C-o> <C-O>

set hidden

" Close the current buffer
map <leader>d :Bclose<cr>

" Close all the buffers
map <leader>da :1,1000 c!<cr>

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" easy buffer switching
map <leader>j :bn<cr>
map <leader>k :bp<cr>

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
    set switchbuf=useopen
    set stal=2
catch
endtry

if has('nvim')
    set showtabline=0
endif

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif
" Remember info about open buffers on close
set viminfo^=%

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

" move lines around
nmap <M-k> mz:m-2<cr>`z
nmap <M-j> mz:m+<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z


"""""""""""""""""""""""""""""""""""""""""
" Misc
"""""""""""""""""""""""""""""""""""""""""

" forgot sudo? ;)
cmap w!! w !sudo tee % >/dev/null


" Delete trailing white space on save
func! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc

" delete trailing whitespaces on write - not using for now, some files need
" whitespace
"autocmd BufWrite * :call DeleteTrailingWS()
"Explicitly enable for filetypes!

" ;w - delete all training WS
nmap <leader>w :call DeleteTrailingWS()<CR>

func! EnableMoveHighlight()
    autocmd CursorMoved * exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))
endfunc

" this is used for latex tech editing to move every sentence to its own line
" with Q
func! FormatOneSentencePerLine(start, end)
    call DeleteTrailingWS()
    silent execute a:start.','.a:end.'s/[.!?]\zs /\r/g'
    silent execute a:start.','.a:end.'s/\([^.!?%}]\)\s*\n/\1 /g'
endfunction

" the most important emoji ¯\_(ツ)_/¯
command Shrug execute "normal! a¯\\_(ツ)_/¯\<Esc>"

"""""""""""""""""""""""""""""""""""""
""""""""" Plugin settings """""""""""
"""""""""""""""""""""""""""""""""""""

"""" tex flavor!
let g:tex_flavor = 'latex'


"""" for smartcolorcolumn
" configure this in filetype specific after/ftplugin/ files
" let g:smart_display_opts = { 'column' : 80 }

"""" fzf in vim
" function! FzfGitCwdFiles(fullscreen)
"   let root_ = split(system('git rev-parse --show-toplevel'), '\n')[0]
"   let root = v:shell_error ? '' : root_
"   if empty(root)
"       return fzf#vim#files(getcwd(), fzf#vim#with_preview(), a:fullscreen)
"   else
"       return fzf#run(fzf#vim#with_preview(fzf#wrap('gcwdfiles', {
"         \ 'source':  'git ls-files --exclude-standard --others --cached '.(has('win32') || has('win64') ? '' : ' | uniq'),
"         \ 'dir': getcwd(),
"         \ 'options': '-m --preview="bat {}" --prompt "GitFiles(PWD)> "'
"         \}, a:fullscreen)))
"   endif
" endfunction
" command! -bang FilesOrGitFiles call FzfGitCwdFiles(<bang>0)

" map <leader>t :Files<cr>
" map <leader>T :GFiles --cached --others --exclude-standard<cr>
" map <leader>f :FilesOrGitFiles<cr>
" map <leader>F :FilesOrGitFiles!<cr>
" map <leader>b :Buffers<cr>
" map <leader>l :BLines<cr>



" function! RgWord()
"     let wordUnderCursor = expand("<cword>")
"     execute ':Rg ' . wordUnderCursor
" endfunction
" map <leader>q :call RgWord()<cr>

"""" for vim-markdown
let g:vim_markdown_math=1
let g:vim_markdown_folding_disabled=1


"" For conceal markers.
"if has('conceal')
"  set conceallevel=2 concealcursor=niv
"endif

"""" for neovim-lsp client

" -> now configured in init.lua
" noremap <localleader>d <cmd>lua vim.lsp.buf.definition()<CR>
" noremap <localleader>D <cmd>lua vim.lsp.buf.declaration()<CR>
" noremap <localleader>x <cmd>lua vim.lsp.buf.references()<CR>
" noremap <localleader>r <cmd>lua vim.lsp.buf.references()<CR>
" nnoremap <silent>gd    <cmd>lua vim.lsp.buf.declaration()<CR>
" nnoremap <silent><c-]> <cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap <silent>K     <cmd>lua vim.lsp.buf.hover()<CR>

"""" for trouble
nnoremap <leader>xx <cmd>TroubleToggle<cr>
nnoremap <leader>xw <cmd>TroubleToggle workspace_diagnostics<cr>
nnoremap <leader>xd <cmd>TroubleToggle document_diagnostics<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
nnoremap gR <cmd>TroubleToggle lsp_references<cr>


"""" for vista

" let g:vista_default_executive = 'nvim-lspconfig'
"let g:vista_fzf_preview = ['right:50%']
" let g:vista#renderer#enable_icon = 1

" let g:vista_executive_for = {
"   \ 'c': 'nvim-lspconfig',
"   \ 'cpp': 'ale',
"   \ 'rust': 'ale',
"   \ 'python': 'ale',
"   \ }

noremap <silent> <leader>S :Vista finder<cr>
"noremap <silent> <leader>V :Vista!!<Return>

"""" for vimtex

if has('nvim')
    " vimtex has not so good support for neovim
    " https://github.com/lervag/vimtex/issues/262
    " the fix is to use neovim-remote (pip install it)
    let g:vimtex_compiler_progname = "nvr"
endif


"""" for vimwiki

let g:vimwiki_list = [{'path': '~/todo/notes/', 'syntax': 'markdown', 'ext': '.md'}]
let g:nv_search_paths = ['~/todo/notes']
let g:zettel_fzf_command = "rg --column --line-number --ignore-case --no-heading --color=always "
nnoremap <leader>zn :ZettelNew<space>


""""" for bibtex-fzf

let FZF_BIBTEX_CACHEDIR = '~/.cache/fzf-bibtex'
function! Bibtex_ls()
  let bibfiles = (
      \ globpath('.', '*.bib', v:true, v:true) +
      \ globpath('..', '*.bib', v:true, v:true) +
      \ globpath('*/', '*.bib', v:true, v:true)
      \ )
  let bibfiles = join(bibfiles, ' ')
  let source_cmd = 'bibtex-ls '.bibfiles
  return source_cmd
endfunction


""" for lightspeed

"if has('nvim')
" currently nothing
"endif



au VimEnter,BufWinEnter,BufRead,BufNewFile *.just setlocal filetype=make
au VimEnter,BufWinEnter,BufRead,BufNewFile justfile setlocal filetype=make
au VimEnter,BufWinEnter,BufRead,BufNewFile Justfile setlocal filetype=make
au VimEnter,BufWinEnter,BufRead,BufNewFile .justfile setlocal filetype=make
au VimEnter,BufWinEnter,BufRead,BufNewFile .Justfile setlocal filetype=make


""" load lua config
if has('nvim')
    lua require('init')
endif
