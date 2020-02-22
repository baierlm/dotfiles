call plug#begin('~/.config/nvim/plugged')

" Latex
Plug 'lervag/vimtex'
Plug 'Konfekt/FastFold' " some speedup
" pip install neovim-remote for refresh compiled pdf

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'https://github.com/junegunn/fzf.vim'

Plug 'vim-syntastic/syntastic'

" Function tagging
"Plug 'xolox/vim-misc'
"Plug 'xolox/vim-easytags'
" Plug 'https://github.com/ludovicchabant/vim-gutentags.git'
" Plug 'majutsushi/tagbar'

Plug 'https://github.com/scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'


Plug 'morhetz/gruvbox'

" Hex color display
" Plug 'ap/vim-css-color'
Plug 'norcalli/nvim-colorizer.lua'

" Language packages
Plug 'sheerun/vim-polyglot'

" Ranger for vim: https://vimawesome.com/plugin/ranger-explorer-vim
Plug 'iberianpig/ranger-explorer.vim'
Plug 'rbgrouleff/bclose.vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'christoomey/vim-tmux-navigator'

" Autocomplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Select regions with J, K
Plug 'terryma/vim-expand-region'

" https://vimawesome.com/plugin/surround-vim
Plug 'tpope/vim-surround'

" TODO checkout navigation binding: https://vimawesome.com/plugin/easymotion
Plug 'easymotion/vim-easymotion'

" Icons, has to be last (Nerd font has to be installed) 
Plug 'ryanoasis/vim-devicons'

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
"set tags=./tags;,~/.vimtags
" Sensible defaults
"let g:easytags_events = ['BufReadPost', 'BufWritePost']
"let g:easytags_async = 1
"let g:easytags_dynamic_files = 2
"let g:easytags_resolve_links = 1
"let g:easytags_suppress_ctags_warning = 1

let g:airline_theme='base16_gruvbox_dark_hard'

" Enable autocomplete
let g:deoplete#enable_at_startup = 1

" vimtex
let g:tex_flavor  = 'latex'
let g:tex_conceal = ''
let g:vimtex_fold_manual = 1
let g:vimtex_latexmk_continuous = 1
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_view_method = 'mupdf'
let g:polyglot_disabled = ['latex']
let  mapleader=" "
source ~/.config/nvim/latex.vim


" resize
noremap <C-j> :resize +1<CR>
noremap <C-k> :resize -1<CR>
noremap <C-h> :vertical resize -1<CR>
noremap <C-l> :vertical resize +1<CR>


nmap <F6> :setlocal spell! spelllang=en_us<CR>
nmap <leader>h :noh<CR>              " Hide search highlighting
nmap <leader>r :so %<CR>             " Reload config
nmap <leader>t :NERDTreeToggle<CR>
" Open/close tagbar with \b
nmap <silent> <leader>b :TagbarToggle<CR>
" copy/paste
vmap <C-y> "+y<CR>
map <C-p> "+p<CR>

map K <Plug>(expand_region_expand)
map J <Plug>(expand_region_shrink)
" search for selected
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

inoremap <Space><Space> <ESC>/<++><Enter>"_c4l


" :%s/\s\+$//e remove training whitespaces
" :s/\s\+/ /g  remove mutiples of whitespaces
