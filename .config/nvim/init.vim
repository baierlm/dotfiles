call plug#begin('~/.config/nvim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'morhetz/gruvbox'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'terryma/vim-expand-region'
Plug 'morhetz/gruvbox'

call plug#end()



" coc
let g:coc_global_extensions = [
	\ 'coc-python',
    \ 'coc-pyright',
    \ 'coc-json',
    \ 'coc-xml',
    \ 'coc-css',
    \ 'coc-tsserver',
    \ 'coc-actions',
    \ 'coc-markdownlint',
	\]


let mapleader=" "
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@


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
"set wildmode=longest,list   " get bash-like tab completions
filetype plugin indent on   " allows auto-indenting depending on file type
syntax on                   " syntax highlighting

set termguicolors           " colorsupport
let g:gruvbox_italic=1
colorscheme gruvbox
let g:airline_theme='base16_gruvbox_dark_hard'



nmap <F6> :setlocal spell! spelllang=en_us<CR>
nmap <leader>h :noh<CR>              " Hide search highlighting
nmap <leader>r :so %<CR>             " Reload config
vmap <C-y> "+y<CR>
map <C-p> "+p<CR>
map K <Plug>(expand_region_expand)
map J <Plug>(expand_region_shrink)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" :%s/\s\+$//e remove training whitespaces
" :s/\s\+/ /g  remove mutiples of whitespaces

