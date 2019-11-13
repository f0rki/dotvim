"""""""""""""""""""""""""""""""""""""""""
" my .vimrc
"
" Here is a quick overview of useful shortcuts

"""" buffer management
" ;d close the buffer
" ;t to open fuzzy file list
" ;b to open fuzzy list of open buffers
"

"""" movement
" f<char> to jump to <char> on line (F for backward)
" 0 go to frist non-blank char in line
" ^ go to actual line start
" $ to line end
" jumplist navigation with C-i and C-o

"""" git
" jump between hunks with: [c and ]c
" stage, unstate with ;hs and ;hu
" preview hunk diff ;hp
" view git diff with :Gdiff
" git blaem with :Gblame

""" vimtex
" ;R start continous compilation
" ;V view pdf / synctex forward search (if already open)

"""""""""""""""""""""""""""""""""""""""""
" plugins
"""""""""""""""""""""""""""""""""""""""""

set nocompatible " be iMproved
filetype off     " required!

let g:python_host_prog = "/usr/bin/python"
let g:python3_host_prog = "/usr/bin/python3"

let g:plug_shallow = 0 " disable shallow clones
" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')

""""""" Plugins

" some sensible defaults
Plug 'tpope/vim-sensible'

""""""" Navigation & Look
" file navigation based on name
"Plug 'kien/ctrlp.vim'
"Plug 'ctrlpvim/ctrlp.vim'
" TODO: checkout out: https://github.com/Lokaltog/vim-easymotion
" Plug 'Lokaltog/vim-easymotion'
" status bar
Plug 'bling/vim-airline'
" display git diff, as sign for added, changed, removed lines
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
" better highlighting for too long lines, instead of colorcolumn
Plug 'gagoar/SmartColumnColors'
" highligh targets for f, F, t, T
Plug 'unblevable/quick-scope'
" TODO: check out movement advice at https://github.com/unblevable/quick-scope
"Plug 'tpope/vim-repeat'
" grep away!
Plug 'mileszs/ack.vim'
"Plug 'wincent/ferret'
"
Plug 'junegunn/fzf', { 'dir': '~/.local/fzf' }
Plug 'junegunn/fzf.vim'

" for word-level diffing in vim
Plug 'rickhowe/diffchar.vim'

" TODO: check-out vim-pencil for writing
" https://github.com/reedes/vim-pencil

"""""" colorschemes
Plug 'Lokaltog/vim-distinguished'
Plug 'michalbachowski/vim-wombat256mod'
"set rtp+=~/.vim/plugged/vim-wombat256mod
"Plug 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}
"set rtp+=~/.vim/plugged/tomorrow-theme/vim/

""""""" general editing helps
" tabular alignment of text
Plug 'godlygeek/tabular'

" checker for writing style
Plug 'reedes/vim-wordy'

" convert latex math stuff to unicode chars
Plug 'joom/latex-unicoder.vim'


""""""" Programming related
" syntax checkers
"Plug 'scrooloose/syntastic'

" auto completion

" previously I used YouCompleteMe a lot
"Plug 'Valloric/YouCompleteMe', {'do': './install.py --system-boost --system-libclang --clang-completer --racer-completer'}
" apparently boost < 1.66 has a bug which breaks YCM
" https://github.com/Valloric/YouCompleteMe/issues/2917#issuecomment-365902233
" so we do not use --system-boost
"Plug 'Valloric/YouCompleteMe', {'do': './install.py --system-libclang --clang-completer --rust-completer --go-completer'}

" Support for language server protocol, which seems to become the standard
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1

Plug 'lighttiger2505/deoplete-vim-lsp'

" ncm2 as completion engine
"Plug 'ncm2/ncm2'
" ncm completion sources
"Plug 'ncm2/ncm2-vim-lsp'
"Plug 'ncm2/ncm2-bufword'
"Plug 'ncm2/ncm2-path'
"Plug 'ncm2/ncm2-ultisnips'

" we use deoplete for completion
"let g:ale_completion_enabled = 0
Plug 'w0rp/ale'
"let g:ale_completion_enabled = 0

" commenting code
Plug 'scrooloose/nerdcommenter'
" Plug 'tpope/vim-commentary'
" auto delimiter insertion
Plug 'Raimondi/delimitMate'
"Plug 'tpope/vim-surround'


" snippets engine
"Plug 'SirVer/ultisnips'
"" and some snippets
Plug 'honza/vim-snippets'
"Plug 'rbonvall/snipmate-snippets-bib'

Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

" various autoformatter
"Plug 'Chiel92/vim-autoformat'

" display docs in the editor
Plug 'Shougo/echodoc.vim'

""""" language support

" latex
"Plug 'vim-latex/vim-latex'
Plug 'lervag/vimtex'
" TODO: checkout the texlab lsp implementation:
" https://github.com/latex-lsp/texlab

" python stuff
"Plug 'voithos/vim-python-matchit'
" python mode combines several useful python plugins
" TODO: check whether to use python mode
"Plug 'klen/python-mode'
"Plug 'tell-k/vim-autopep8'
"Plug 'nvie/vim-flake8'
"Plug 'ncm2/ncm2-jedi'
Plug 'deoplete-plugins/deoplete-jedi'

" C/C++ 
"Plug 'ncm2/ncm2-pyclang'

" rust
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'

" go stuff
"Plug 'ncm2/ncm2-go'

" misc formats
Plug 'dag/vim-fish'
Plug 'plasticboy/vim-markdown'
Plug 'ethereum/vim-solidity'
"Plug 'derekwyatt/vim-scala'
"Plug 'kchmck/vim-coffee-script'
"Plug 'vim-scripts/yaml.vim'
"Plug 'godlygeek/tabular'
" meh pulling the whole docker repo only for vim syntax is annoying
"Plug 'docker/docker' , {'rtp': '/contrib/syntax/vim/'}
"Plug 'ncm2/ncm2-markdown-subscope'
"Plug 'ncm2/ncm2-rst-subscope'
"Plug 'deoplete-plugins/deoplete-docker'
Plug 'fszymanski/deoplete-emoji'

""""" required, end of plugin loading
call plug#end()


""""" external/system plugins """""""

if file_readable(expand("$GOROOT/misc/vim/"))
    set rtp+=$GOROOT/misc/vim
elseif file_readable(expand("/usr/share/go/misc/vim/"))
    set rtp+=/usr/share/go/misc/vim/
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" we need this when using fish, or otherwise some plugins are fubar
set shell=/bin/bash
" disable vi compat
set nocompatible
" we want line numbers
set number
" Sets how many lines of history VIM has to remember
set history=700
" Set to auto read when a file is changed from the outside
set autoread
" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
" TODO: consider alternative leader
let mapleader = ";"
let maplocalleader = "'"
let g:mapleader = ";"
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
set wildignore+=*_build/*
set wildignore+=*build/*
set wildignore+=*/coverage/*

" let tab trigger auto completion
set wildchar=<Tab> wildmenu wildmode=full

if has('mouse')
    set mouse=a
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable syntax highlighting
syntax enable

" Set extra options when running in GUI mode
if has("gui_running")
    "colorscheme github
    colorscheme wombat256mod
    set guioptions-=T
    set guioptions-=e
    " highlight ColorColumn guibg=lightgrey
else
    colorscheme darkdot
endif

if has("nvim") || has("gui_running")
    " copypasta from X clipboard
    nmap <leader>P "+gP
    nmap <leader>Y "+y
    vmap <leader>Y "+y
endif

if has("nvim")
    colorscheme wombat256mod
    "colorscheme Tomorrow-Night
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

" delete trailing whitespaces on write
"autocmd BufWrite * :call DeleteTrailingWS()
"Explicitly enable for filetypes!
nmap <leader>w :call DeleteTrailingWS()

func! EnableMoveHighlight()
    autocmd CursorMoved * exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))
endfunc

func! FormatOneSentencePerLine(start, end)
    call DeleteTrailingWS()
    silent execute a:start.','.a:end.'s/[.!?]\zs /\r/g'
    silent execute a:start.','.a:end.'s/\([^.!?%}]\)\s*\n/\1 /g'
endfunction


"""""""""""""""""""""""""""""""""""""
""""""""" Plugin settings """""""""""
"""""""""""""""""""""""""""""""""""""

" configure ack.vim to use ripgrep :)
let g:ackprg = 'rg --vimgrep --no-heading'

""" expand ultisnips
"let g:UltiSnipsExpandTrigger="<leader>s"

"noremap <F4> :Autoformat<CR>
"let g:formatter_yapf_style = 'pep8'
"let g:formatters_python = ['yapf']

"let g:formatdef_biber_fmt = '"biber --tool --output-align --output-indent=2 --output-fieldcase=lower -O - "'
"let g:formatters_bib = ['biber_fmt']

"""" for tagbar
"nmap <F8> :TagbarToggle<CR>

"""" python configuration
"map <buffer> <F4> :call Autopep8()<CR>
"

"""" for YouCompleteMe
"let g:ycm_server_python_interpreter = "/usr/bin/python3"
"let g:ycm_python_binary_path = 'python3'

" python-mode config (disabled)
" disable python folding
"let g:pymode_folding = 0
" Disable pylint checking every save
"let g:pymode_lint_write = 0
" Load run code plugin
"let g:pymode_run = 0
" the checkers
"let g:pymode_lint_checker = "flake8"


"""" latex unicoder
let g:unicoder_no_map=0
"nnoremap <F10> :call unicoder#start(0)<CR>
"nnoremap <leader> :call unicoder#start(0)<CR>
map <leader><F9> :call unicoder#start(0)<CR>


"""" tex flavor!
let g:tex_flavor = 'latex'


"""" for airline
set laststatus=2

"""" for smartcolorcolumn
" configure this in filetype specific after/ftplugin/ files
" let g:smart_display_opts = { 'column' : 80 }

"""" settings for ctrlp
"let g:ctrlp_max_height = 30
"map <leader>t :CtrlP<cr>
"map <leader>b :CtrlPBuffer<cr>
"map <leader>r :CtrlPMixed<cr>
"let g:ctrlp_working_path_mode = 'a'

"""" alternatively we use fzf vim now
map <leader>t :Files<cr>
map <leader>b :Buffers<cr>
map <leader>l :BLines<cr>
"map <leader>r :CtrlPMixed<cr>


"""" for syntastic
" configure py/C checkers, although they are handled by YCM on recent vims
"let g:syntastic_python_checkers = ['flake8', 'python']
"let g:syntastic_c_checkers = ['gcc']

"""" for vim-markdown
let g:vim_markdown_math=1
let g:vim_markdown_folding_disabled=1

"""" for rust.vim
" auto-format rust code on save
let g:rustfmt_autosave = 1

"let g:syntastic_rust_checkers = ['rustc']
" Naturally, this needs to be set to wherever your rust
" source tree resides.
"if file_readable('/usr/src/rust/src/')
"    let g:ycm_rust_src_path = '/usr/src/rust/src/'
"else
"    let g:ycm_rust_src_path = '~/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src/'
"endif

"""" for ncm2
"autocmd BufEnter * call ncm2#enable_for_buffer()
"" IMPORTANT: :help Ncm2PopupOpen for more information
"set completeopt=noinsert,menuone,noselect
"set shortmess+=c
"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


"""" for deoplete
inoremap <expr> <Tab> pumvisible() ? "\<C-N>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-P>" : "\<S-Tab>"

let g:deoplete#enable_at_startup = 1

"""" for neosnippets
" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/plugged/vim-snippets/snippets'

imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

"" For conceal markers.
"if has('conceal')
"  set conceallevel=2 concealcursor=niv
"endif


"""" for echodoc

set cmdheight=2
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'signature'


"""" for ALE

noremap <F4> :ALEFix<CR>


"""" for vimtex

if has('nvim')
    " vimtex has not so good support for neovim
    " https://github.com/lervag/vimtex/issues/262
    " the fix is to use neovim-remote (pip install it)
    let g:vimtex_compiler_progname = "nvr"
endif
