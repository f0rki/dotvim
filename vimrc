"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" my .vimrc 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" disable vi compat
set nocompatible
" we want line numbers
set number
" Sets how many lines of history VIM has to remember
set history=700
" Enable filetype plugins
filetype plugin on
filetype indent on
" Set to auto read when a file is changed from the outside
set autoread
" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ";"
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
set wildignore+=*_build/*
set wildignore+=*build/*
set wildignore+=*/coverage/*

" let tab trigger auto completion
set wildchar=<Tab> wildmenu wildmode=full

set pastetoggle=<F11>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable syntax highlighting
syntax enable 

" colorscheme
" colorscheme desert
colorscheme default
set background=dark

" Set extra options when running in GUI mode
if has("gui_running")
    "TODO: 
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" set column at 81 per default
set colorcolumn=81
highlight ColorColumn ctermbg=lightgrey guibg=lightgrey



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile


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

" Linebreak on 500 characters
set lbr
set tw=500

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

set hidden

" Close the current buffer
map <leader>c :Bclose<cr>

" Close all the buffers
map <leader>ca :1,1000 c!<cr>

" Useful mappings for managing tabs
"map <leader>tn :tabnew<cr>
"map <leader>to :tabonly<cr>
"map <leader>tc :tabclose<cr>
"map <leader>tm :tabmove 


" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l


" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

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


"""""""""""""""""""""""""""""""""""""""""
" plugins
"""""""""""""""""""""""""""""""""""""""""

"" use pathogen to load vim plugins
runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()


"" plugin options/mappings
nmap <F8> :TagbarToggle<CR>


"" NERDTree configuration
let g:NERDTreeWinPos = "right"
"let g:NERDTreeWinSize = 31
nmap <leader>n :NERDTreeToggle<RETURN>


"" configuration of flake8 plugin
let g:flake8_cmd="/usr/bin/flake8"


"" python-mode configuration
" disable python folding
let g:pymode_folding = 0
" Disable pylint checking every save
let g:pymode_lint_write = 0
" Load run code plugin
let g:pymode_run = 0
" the checkers
let g:pymode_lint_checker = "flake8"


"" for powerline
set rtp+=/home/mikey/.vim/bundle/powerline/powerline/bindings/vim
let g:Powerline_symbols = 'fancy'
set laststatus=2
set encoding=utf-8


"" settings for ctrlp
let g:ctrlp_max_height = 30
map <leader>t :CtrlPMixed<cr>

