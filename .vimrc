set rtp+=~/.config/vim/
call plug#begin('~/.config/vim/plugged')
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'mboughaba/i3config.vim'
Plug 'davidhalter/jedi-vim'
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/vim-easy-align'
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
set ignorecase
set smartcase
set t_Co=256

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

map <C-n> :NERDTreeToggle<CR>
nnoremap <C-m> :exec &mouse!="" ? "set mouse=" : "set mouse=a"<CR>
