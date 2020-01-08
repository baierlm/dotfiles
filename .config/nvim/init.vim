call plug#begin('~/.config/nvim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'https://github.com/junegunn/fzf.vim'

Plug 'vim-syntastic/syntastic'

" Function tagging
Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'
Plug 'majutsushi/tagbar'

Plug 'https://github.com/scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'

Plug 'morhetz/gruvbox'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'christoomey/vim-tmux-navigator'

call plug#end()

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

let g:gruvbox_italic=1
colorscheme gruvbox

" ----- xolox/vim-easytags settings -----
" Where to look for tags files
set tags=./tags;,~/.vimtags
" Sensible defaults
let g:easytags_events = ['BufReadPost', 'BufWritePost']
let g:easytags_async = 1
let g:easytags_dynamic_files = 2
let g:easytags_resolve_links = 1
let g:easytags_suppress_ctags_warning = 1

let  mapleader=" "

" resize
noremap <C-j> :resize +1<CR>
noremap <C-k> :resize -1<CR>
noremap <C-h> :vertical resize -1<CR>
noremap <C-l> :vertical resize +1<CR>

nmap <leader>h :noh<CR>              " Hide search highlighting
nmap <leader>r :so %<CR>             " Reload config
nmap <leader>t :NERDTreeToggle<CR>
" Open/close tagbar with \b
nmap <silent> <leader>b :TagbarToggle<CR>
" copy/paste
vmap <C-y> "+y<CR>
map <C-p> "+p<CR>


" :%s/\s\+$//e remove training whitespaces
" :s/\s\+/ /g  remove mutiples of whitespaces
