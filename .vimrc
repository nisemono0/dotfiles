" Plugins
set rtp+=~/.config/vim/
call plug#begin('~/.config/vim/plugged')
    " Web
    Plug 'preservim/nerdtree'
    Plug 'vim-airline/vim-airline'
    Plug 'davidhalter/jedi-vim'
    Plug 'ryanoasis/vim-devicons'
    Plug 'junegunn/vim-easy-align'
    Plug 'cohama/lexima.vim'
    Plug 'dhruvasagar/vim-table-mode'
    Plug 'machakann/vim-highlightedyank'
    Plug 'andymass/vim-matchup'
    Plug 'mbbill/undotree'
    Plug 'junegunn/fzf.vim'
    Plug 'tpope/vim-fugitive'
    " Local
    Plug '~/.config/vim/plugged/minimalist'
call plug#end()

" General
set viminfofile=~/.cache/vim/viminfo
set undodir=~/.cache/vim/undodir
set noswapfile
set nobackup
set undofile
set autoread
set autochdir

" Indent and line numbers
filetype indent on
syntax on
set ts=4 sw=4 sts=4
set number
set relativenumber
set smarttab
set expandtab

" Search
set hlsearch
set incsearch
set ignorecase
set smartcase

" Look
colorscheme minimalist
set laststatus=2
set ruler
set wildmenu
set list
set listchars=tab:→\ ,nbsp:␣,trail:•,extends:❯,precedes:❮

" Scroll
set scrolloff=4
set sidescrolloff=4
set display+=lastline
set display+=truncate

" Format
set formatoptions+=j
set nrformats-=octal

" Timeout
set ttimeout
set ttimeoutlen=100
set updatetime=100

" Misc
set nocompatible
set nolangremap
set backspace=indent,eol,start
set t_Co=256
set t_RV=

" Display man pages
if exists(':Man') != 2 && !exists('g:loaded_man') && &filetype !=? 'man' && !has('nvim')
    runtime ftplugin/man.vim
endif

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

" Airline
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

" Lexima
let g:lexima_no_default_rules = 1
call lexima#set_default_rules()
call lexima#insmode#map_hook('before', '<CR>', '')

" Highlight yank
let b:highlightedyank_highlight_duration = 50
let g:highlightedyank_highlight_in_visual = 0

" Toggle NerdTree
map <C-n> :NERDTreeToggle<CR>

" Completion window
inoremap <C-@> <C-n>
inoremap <C-Space> <C-n>
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <TAB> pumvisible() ? "\<C-y>" : "\<TAB>"

" Buffer keybinds
map <Leader>bn :bnext<CR>
map <Leader>bp :bprevious<CR>
map <Leader>bd :bdelete<CR>

" Center after moving up/down
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz

" Center after searching
nnoremap n nzzzv
nnoremap N Nzzzv

" Clear search
nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>

" Toggle UndoTree
nnoremap <Leader>u :UndotreeToggle<CR>

" fzf keybinds
nnoremap <Leader>ff :Files<CR>
nnoremap <Leader>fg :GFiles<CR>
nnoremap <Leader>fb :Lines<CR>
nnoremap <Leader>ft :BLines<CR>
nnoremap <Leader>fl :BLines<CR>
nnoremap <Leader>fp :Rg<CR>
nnoremap <Leader>fB :Buffers<CR>

" vim-fugitive keybind
nnoremap <Leader>gs :Git<CR>

" Move selection up/down and indent
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Don't overwrite register
xnoremap <Leader>p "_dP
nnoremap <Leader>d "_d
vnoremap <Leader>d "_d

" Disable Q
nnoremap Q <NOP>

" Replace all instances of selected word
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//gI<Left><Left><Left>

" Make file executable
nnoremap <Leader>x <CMD>!chmod +x %<CR>

" Allow use of backspace in normal mode
nnoremap <Backspace> X

