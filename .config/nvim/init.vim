set showmatch               " show matching brackets.
set ignorecase              " case insensitive matching
set mouse=v                 " middle-click paste with mouse
set hlsearch                " highlight search results
set tabstop=4               " number of columns occupied by a tab character
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the 
                            " right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line 
                            " just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
filetype plugin indent on   " allows auto-indenting depending on file type
syntax on                   " syntax highlighting

set splitbelow              " set split direction
set splitright

set termguicolors           " colorsupport

let mapleader=" "

map <leader>h :noh<CR>              " Hide search highlighting
map <leader>r :so %<CR>             " Reload config
map <leader>t :NERDTreeToggle<CR>   

call plug#begin('~/.config/nvim/plugged')

Plug 'https://github.com/junegunn/fzf.vim'

Plug 'https://github.com/dense-analysis/ale'

Plug 'https://github.com/scrooloose/nerdtree'

Plug 'morhetz/gruvbox'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

let g:gruvbox_italic=1

colorscheme gruvbox


