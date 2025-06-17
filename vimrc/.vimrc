set nocompatible
filetype on
filetype plugin on
filetype indent on
syntax on
set number
set mouse=a
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
set autoindent
set showmatch
set incsearch
set hlsearch
set ignorecase
set smartcase
set wildmenu
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8
set clipboard=unnamedplus
set nobackup
set noswapfile
set scrolloff=10
set nowrap
set ignorecase
set smartcase
set showmatch

"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ [BUFFER=%n]\ %{strftime('%c')}
set laststatus=2

let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_altv = 1
let g:netrw_winsize = 25

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_user_command = 'find %s -type f'

let g:NERDTreeDirArrowExpandable = '>'
let g:NERDTreeDirArrowCollapsible = 'v'

let g:airline_powerline_fonts = 1

let g:airline#extensions#tabline#enabled = 1

let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = ' '
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#right_alt_sep = ' '
let g:airline#extensions#tabline#right_sep = ' '
