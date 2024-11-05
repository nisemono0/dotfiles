set rtp+=~/.config/vim/
call plug#begin('~/.config/vim/plugged')
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'davidhalter/jedi-vim'
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/vim-easy-align'
Plug 'cohama/lexima.vim'
Plug 'dhruvasagar/vim-table-mode'
Plug 'machakann/vim-highlightedyank'
"Local
Plug '~/.config/vim/plugged/minimalist'
call plug#end()

set viminfo+=n~/.config/vim/viminfo

syntax on
filetype indent on
set ts=4 sw=4
set number
set expandtab
set hlsearch
set incsearch
set ignorecase
set smartcase
set t_Co=256
set relativenumber

"Cursor settings:
"SI = INSERT mode
"SR = REPLACE mode
"EI = NORMAL mode (ELSE)
"   1 -> blinking block
"   2 -> solid block
"   3 -> blinking underscore
"   4 -> solid underscore
"   5 -> blinking vertical bar
"   6 -> solid vertical bar
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

colorscheme minimalist
let g:airline_theme='minimalist'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.readonly = '🔒'
let g:airline_symbols.linenr = '㏑'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.colnr= '㏇'
let g:airline_symbols.whitespace = ''

let g:lexima_no_default_rules = 1
call lexima#set_default_rules()
call lexima#insmode#map_hook('before', '<CR>', '')

let b:highlightedyank_highlight_duration = 50
let g:highlightedyank_highlight_in_visual = 0

inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <TAB> pumvisible() ? "\<C-y>" : "\<TAB>"

inoremap <C-@> <C-n>
inoremap <C-Space> <C-n>

map <C-n> :NERDTreeToggle<CR>
nnoremap <C-m> :exec &mouse!="" ? "set mouse=" : "set mouse=a"<CR>

map gb :bnext<CR>
map gB :bprevious<CR>
map gbd :bdelete<CR>

set t_RV=
