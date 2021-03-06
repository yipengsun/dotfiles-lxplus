" vim:fdm=marker

"{{{ Generic

" Disable vi compatible mode
set nocp

" Set to auto read when a file is changed from the outside
set autoread

" Restore cursor position
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" Persistence undo
"set udf
"set ul=500

" Aggregate all .swp files in a single directory
set directory=$HOME/.tmp/vim

" Mouse support
if has('mouse')
    set mouse=a
endif

" Filecodings settings
set enc=utf-8
set fencs=utf-8,cp936,ucs-bom,gb18030,gbk,gb2312
let &termencoding=&encoding

" Backup settings
set nobackup
set nowritebackup

" Current directory settings
set autochdir
set sessionoptions-=curdir

" Folding settings
set foldenable
set foldmethod=syntax
set foldcolumn=3

" Backspace settings
set backspace=eol,start,indent

" Tab settings
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab

"}}}

"{{{ Interface

" UI settings
set shortmess=atI
set showcmd

" Statusbar settings
set cmdheight=1
set laststatus=2

" Cursor settings
set so=7
set gcr=n-c-v-i:block
set gcr=a:blinkon0
set novisualbell
au InsertEnter * set cursorline
au InsertLeave * set nocursorline
"au InsertEnter * set cursorcolumn
"au InsertLeave * set nocursorcolumn

" Linebreak settings
set linebreak
set iskeyword+=_,$,@,%,#,-
set wrap

" Show line number by default
set number

" Turn on wildmenu
set wildmenu
set wildmode=longest:full,full

"}}}

"{{{ Search

" Basic matching settings
set magic
set showmatch

" Hilight search results
set hlsearch

" Ignore case when searching
set ignorecase
set smartcase

" Incremental match when searching
set incsearch

"}}}

"{{{ Mapping

" Disable Ex mode
nnoremap Q <NOP>

" Tab navigation
nnoremap tp :tabprevious<CR>
nnoremap tn :tabnext<CR>
nnoremap to :tabnew
nnoremap tc :tabclose<CR>

" Move among windows
nnoremap <C-DOWN> <C-w>j
nnoremap <C-UP> <C-w>k
nnoremap <C-LEFT> <C-w>h
nnoremap <C-RIGHT> <C-w>l

" Indent text in visual/normal mode via tab/shift-tab
nnoremap <TAB> v>
nnoremap <S-TAB> v<
vnoremap <TAB> >gv
vnoremap <S-TAB> <gv

" Auto close pairs in visual mode
vnoremap ( s()<ESC>P<RIGHT>%
vnoremap [ s[]<ESC>P<RIGHT>%
vnoremap { s{}<ESC>P<RIGHT>%
vnoremap < s<><ESC>P<RIGHT>%
vnoremap ` s``<ESC>P<RIGHT>%
vnoremap ' s''<ESC>P<RIGHT>%
vnoremap " s""<ESC>P<RIGHT>%

" Folding switch
nnoremap <silent><SPACE> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

" Disable search hilight
nnoremap <silent><C-k> <ESC>:nohl<CR>

" Set Ctrl-c, Ctrl-v, Ctrl-x as newer programs do
vnoremap <C-c> "+y
inoremap <silent><C-v> <ESC>:set paste<CR>mui<C-R>+<ESC>:set nopaste<CR>
vnoremap <C-x> "+x

" Function-keys mapping
nnoremap <F1> <NOP>
inoremap <F1> <NOP>
vnoremap <F1> <NOP>
inoremap <silent><F3> <C-R>=strftime("%F")<BAR><CR>

"}}}

"{{{ Plugin manager

filetype plugin indent on
syntax on

call plug#begin('~/.vim/bundle')

" Theme
Plug 'dracula/vim', { 'as': 'dracula' }

" Bare minimum plugins
Plug 'Raimondi/delimitMate'
Plug 'preservim/nerdcommenter'
"Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'

" IDE
Plug 'ervandew/supertab'

call plug#end()

"}}}

"{{{ Color

" Colorscheme settings
colorscheme dracula

" Highlight the 81st column
set colorcolumn=81

"}}}
