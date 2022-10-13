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

"""""""""""""""""""""""""""""""""""""""""
" plugins
"""""""""""""""""""""""""""""""""""""""""

set nocompatible " be iMproved
filetype off     " required!

let g:plug_shallow = 0 " disable shallow clones
" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')

""""""" Plugins

" some sensible defaults
Plug 'tpope/vim-sensible'

" support libs
if has('nvim')
    Plug 'nvim-lua/plenary.nvim'
endif

""""""" Navigation & Look

" TODO: checkout out: https://github.com/Lokaltog/vim-easymotion
" Plug 'Lokaltog/vim-easymotion'
" status bar
if has('nvim')
    Plug 'hoob3rt/lualine.nvim'
    " If you want to have icons in your statusline choose one of these
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'ryanoasis/vim-devicons'
endif
" display git diff, as sign for added, changed, removed lines
"Plug 'airblade/vim-gitgutter'
if has('nvim') || has('patch-8.0.902')
  Plug 'mhinz/vim-signify'
else
  Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif
" integrated git support
Plug 'tpope/vim-fugitive'
" better highlighting for too long lines, instead of colorcolumn
" doesn't work well with neovim and
"Plug 'gagoar/SmartColumnColors'

" highligh targets for f, F, t, T
Plug 'unblevable/quick-scope'
" TODO: check out movement advice at https://github.com/unblevable/quick-scope
if has('nvim')
    Plug 'ggandor/lightspeed.nvim'
endif

"Plug 'tpope/vim-repeat'
Plug 'junegunn/fzf', { 'dir': '~/.local/fzf' }
Plug 'junegunn/fzf.vim'

" TODO: check out telescope.nvim as an alternative to the fzf plugin
"Plug 'nvim-telescope/telescope.nvim'
"Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
"Plug 'AckslD/nvim-neoclip.lua'
"Plug 'ElPiloto/telescope-vimwiki.nvim'

if has('nvim')
    Plug 'nvim-treesitter/nvim-treesitter', {'branch' : '0.5-compat', 'do': ':TSUpdate'}
    Plug 'nvim-treesitter/nvim-treesitter-textobjects', {'branch' : '0.5-compat'}
    Plug 'IndianBoy42/tree-sitter-just'
    Plug 'm-demare/hlargs.nvim'
endif


"Plug 'fiatjaf/neuron.vim'
Plug 'vimwiki/vimwiki'
Plug 'michal-h21/vim-zettel'


" for word-level diffing in vim
Plug 'rickhowe/diffchar.vim'

" highlight yank
Plug 'machakann/vim-highlightedyank'

" TODO: check-out vim-pencil for writing
" https://github.com/reedes/vim-pencil

" TODO: check out show a nice minimap
"Plug 'wfxr/minimap.vim', {'do': ':!cargo install --locked code-minimap'}

"""""" colorschemes
"Plug 'Lokaltog/vim-distinguished'
"Plug 'michalbachowski/vim-wombat256mod'
if has('nvim')
    Plug 'navarasu/onedark.nvim'
    "Plug 'rafamadriz/neon'
    Plug 'marko-cerovac/material.nvim'
    Plug 'projekt0n/github-nvim-theme'
endif

""""""" general editing helps
" tabular alignment of text
Plug 'godlygeek/tabular'

" checker for writing style
Plug 'reedes/vim-wordy'

" convert latex math stuff to unicode chars
Plug 'joom/latex-unicoder.vim'


""""""" Programming related
" auto completion

" Support for language server protocol, which seems to become the standard
"Plug 'prabirshrestha/async.vim'
"Plug 'prabirshrestha/vim-lsp'
"
"Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'make release'}
"
" deoplete as completion engine
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1

" we use deoplete for completion, but get the completion sources from ALE
let g:ale_completion_enabled = 0
Plug 'dense-analysis/ale'
" Plug 'f0rki/ale', { 'dir': '~/src/ale' }
" Plug '~/src/ale'


if has('nvim')
    Plug 'neovim/nvim-lspconfig'

    " meh I install LSPs on my own; don't need another package manger...
    " Plug 'williamboman/nvim-lsp-installer'
    
    " languagetool integration
    " Plug 'brymer-meneses/grammar-guard.nvim'

    Plug 'folke/trouble.nvim'
endif

" commenting code
if has('nvim')
    " Plug 'numToStr/Comment.nvim'
    " Plug 'numToStr/Comment.nvim', { 'tag': 'v0.6' }
    Plug 'numToStr/Comment.nvim'
else
    Plug 'scrooloose/nerdcommenter'
endif

" Plug 'tpope/vim-commentary'
" auto delimiter insertion
"Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-surround'

Plug 'liuchengxu/vista.vim'


" snippets engine
"Plug 'SirVer/ultisnips'
"" and some snippets
Plug 'honza/vim-snippets'
"Plug 'rbonvall/snipmate-snippets-bib'

Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

" display docs in the editor
Plug 'Shougo/echodoc.vim'

""""" language support

" latex
"Plug 'vim-latex/vim-latex'
Plug 'lervag/vimtex'
" TODO: checkout the texlab lsp implementation:
" https://github.com/latex-lsp/texlab

" python stuff
Plug 'deoplete-plugins/deoplete-jedi'
if has('nvim')
    Plug 'deoplete-plugins/deoplete-lsp'
endif

" rust
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
if has('nvim')
    Plug 'simrat39/rust-tools.nvim'
endif

" other formats/languages
Plug 'dag/vim-fish'
Plug 'plasticboy/vim-markdown'
Plug 'ethereum/vim-solidity'
"Plug 'derekwyatt/vim-scala'
"Plug 'kchmck/vim-coffee-script'
"Plug 'vim-scripts/yaml.vim'
Plug 'freitass/todo.txt-vim'
Plug 'LnL7/vim-nix'

" Deoplete completion sources:
Plug 'Shougo/neco-syntax'

" TODO: those two look nice, but don't seem to work properly...
"Plug 'Inazuma110/deoplete-greek'
Plug 'f0rki/deoplete-emoji'
"Plug '~/code/deoplete-emoji'


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
    autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID"
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable syntax highlighting
syntax enable

if has("nvim")
    set termguicolors
    let g:material_style = 'darker'
    colorscheme material
    "colorscheme github_dark_default
    "colorscheme onedark
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

"""" fzf in vim
function! FzfGitCwdFiles(fullscreen)
  let root_ = split(system('git rev-parse --show-toplevel'), '\n')[0]
  let root = v:shell_error ? '' : root_
  if empty(root)
      return fzf#vim#files(getcwd(), fzf#vim#with_preview(), a:fullscreen)
  else
      return fzf#run(fzf#vim#with_preview(fzf#wrap('gcwdfiles', {
        \ 'source':  'git ls-files --exclude-standard --others --cached '.(has('win32') || has('win64') ? '' : ' | uniq'),
        \ 'dir': getcwd(),
        \ 'options': '-m --preview="bat {}" --prompt "GitFiles(PWD)> "'
        \}, a:fullscreen)))
  endif
endfunction
command! -bang FilesOrGitFiles call FzfGitCwdFiles(<bang>0)

map <leader>t :Files<cr>
map <leader>T :GFiles --cached --others --exclude-standard<cr>
map <leader>f :FilesOrGitFiles<cr>
map <leader>F :FilesOrGitFiles!<cr>
map <leader>b :Buffers<cr>
map <leader>l :BLines<cr>

function! RgWord()
    let wordUnderCursor = expand("<cword>")
    execute ':Rg ' . wordUnderCursor
endfunction
map <leader>q :call RgWord()<cr>

"""" for vim-markdown
let g:vim_markdown_math=1
let g:vim_markdown_folding_disabled=1

"""" for neosnippets
" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/plugged/vim-snippets/snippets'

imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

"" For conceal markers.
"if has('conceal')
"  set conceallevel=2 concealcursor=niv
"endif


"""" for deoplete

" cycle through completion with tab
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : (neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>")
" cycle reverse with shift+tab
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<C-h>"

" ctrl+e to cancel the popup
inoremap <expr><C-e>  deoplete#cancel_popup()

"inoremap <expr><C-h> deoplete#toggle()

call deoplete#custom#source('emoji', {'converters': ['converter_emoji'],'filetypes': []})


call deoplete#custom#option('camel_case', v:true)
call deoplete#custom#option('smart_case', v:true)
call deoplete#custom#option('sources', {
      \ '_': ['lsp', 'tag', 'buffer', 'file', 'ale', 'syntax', 'greek', 'emoji'],
      \ 'python': ['lsp', 'tag', 'buffer', 'jedi', 'file', 'ale', 'syntax', 'greek', 'emoji'],
\})


"""" for echodoc

set cmdheight=2
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'signature'


"""" for ALE

noremap <F4> :ALEFix<CR>

" noremap <localleader>d :ALEGoToDefinition<cr>
" noremap <localleader>t :ALEGoToTypeDefinition<cr>
" noremap <localleader>x :ALEFindReferences -relative<cr>

" airline/ALE integration
let g:airline#extensions#ale#enabled = 1


"""" for neovim-lsp client

noremap <localleader>d <cmd>lua vim.lsp.buf.definition()<CR>
noremap <localleader>t <cmd>lua vim.lsp.buf.declaration()<cr>
noremap <localleader>x <cmd>lua vim.lsp.buf.references()<CR>
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

let g:vista_default_executive = 'nvim-lspconfig'
"let g:vista_fzf_preview = ['right:50%']
let g:vista#renderer#enable_icon = 1

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


""""" form bibtex-fzf

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
    lua require'init'
endif
