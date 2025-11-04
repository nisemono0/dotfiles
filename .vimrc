vim9script

# Plugins
set rtp+=~/.config/vim/
plug#begin('~/.config/vim/plugged')
    # Web
    Plug 'preservim/nerdtree'
    Plug 'chriszarate/yazi.vim'
    Plug 'vim-airline/vim-airline'
    Plug 'ryanoasis/vim-devicons'
    Plug 'sheerun/vim-polyglot'
    Plug 'junegunn/vim-easy-align'
    Plug 'cohama/lexima.vim'
    Plug 'tpope/vim-commentary'
    Plug 'machakann/vim-highlightedyank'
    Plug 'andymass/vim-matchup'
    Plug 'mbbill/undotree'
    Plug 'junegunn/fzf.vim'
    Plug 'tpope/vim-fugitive'
    Plug 'yegappan/lsp'
    Plug 'hrsh7th/vim-vsnip'
    Plug 'hrsh7th/vim-vsnip-integ'
    Plug 'rafamadriz/friendly-snippets'
    # Local
    Plug '~/.config/vim/plugged/local-colors'
plug#end()

# General
set viminfofile=~/.cache/vim/viminfo
set undodir=~/.cache/vim/undo
#set undofile
set noswapfile
set nobackup
set autoread
set autochdir

# Indent and line numbers
filetype plugin indent on
syntax on
set ts=4 sw=4 sts=4
set number
set relativenumber
set smarttab
set expandtab

# Search
set hlsearch
set incsearch
set ignorecase
set smartcase

# Look
colorscheme snow
set laststatus=2
set ruler
set wildmenu
set termwinsize=15x0
set list
set listchars=tab:→\ ,nbsp:␣,trail:•,extends:❯,precedes:❮
set pumheight=8

# Scroll
set scrolloff=4
set sidescrolloff=4
set display+=lastline
set display+=truncate

# Format
set formatoptions+=j
set nrformats-=octal

# Timeout
set ttimeout
set ttimeoutlen=100
set updatetime=100

# Autocompletion
set autocomplete
set autocompletetimeout=100
set autocompletedelay=100
set complete=o,.,Fvsnip#completefunc,w,b,u
set completeopt=menu,preview,popup,fuzzy,nosort,noselect

# Command autocompletion
autocmd CmdlineChanged [:\/\?] call wildtrigger()
set wildmode=noselect:lastused,full
set wildoptions=pum
# Keep normal command history navigation
cnoremap <expr> <Up> wildmenumode() ? '<C-E><Up>' : '<Up>'
cnoremap <expr> <Down> wildmenumode() ? '<C-E><Down>' : '<Down>'

# Misc
set nocompatible
set nolangremap
set splitright
set splitbelow
set backspace=indent,eol,start
set t_Co=256
set t_RV=

# Display man pages
if exists(':Man') != 2 && !exists('g:loaded_man') && &filetype !=? 'man' && !has('nvim')
    runtime ftplugin/man.vim
endif

# Cursor settings:
# SI = INSERT mode
# SR = REPLACE mode
# EI = NORMAL mode (ELSE)
# TI = START vim
# TE = EXIT vim
#    1 -> blinking block
#    2 -> solid block
#    3 -> blinking underscore
#    4 -> solid underscore
#    5 -> blinking vertical bar
#    6 -> solid vertical bar
&t_SI = "\<Esc>[6 q"
&t_SR = "\<Esc>[4 q"
&t_EI = "\<Esc>[2 q"
&t_TI = "\<Esc>[2 q"
&t_TE = "\<Esc>[6 q"

# Airline
g:airline_theme = 'minimalist'
g:airline_powerline_fonts = 1
g:airline#extensions#tabline#enabled = 1
if !exists('g:airline_symbols')
    g:airline_symbols = {}
endif
g:airline_left_sep = ''
g:airline_left_sep = ''
g:airline_right_sep = ''
g:airline_right_sep = ''
g:airline_symbols.crypt = '🔒'
g:airline_symbols.readonly = '🔒'
g:airline_symbols.linenr = '㏑'
g:airline_symbols.maxlinenr = ''
g:airline_symbols.colnr = '㏇'
g:airline_symbols.whitespace = ''

# Lexima
g:lexima_no_default_rules = 0
g:lexima_accept_pum_with_enter = 0
g:lexima_map_escape = ''

# Highlight yank
b:highlightedyank_highlight_duration = 50
g:highlightedyank_highlight_in_visual = 0

# Update file
nnoremap <silent> <C-s> :update<CR>
inoremap <silent> <C-s> <Esc>:update<CR>
vnoremap <silent> <C-s> <Esc>:update<CR>

# Show registers
nnoremap <leader>r :registers<CR>

# Toggle NerdTree
nnoremap <C-n> :NERDTreeToggle<CR>

# Open Yazi
nnoremap <silent> _ :Yazi<CR>
nnoremap <silent> - :YaziWorkingDirectory<CR>

# Completion window and snippet jump
inoremap <C-@> <C-n>
inoremap <C-Space> <C-n>
inoremap <expr> <Up> pumvisible() ? '<C-p>' : '<Up>'
inoremap <expr> <Down> pumvisible() ? '<C-n>' : '<Down>'
inoremap <expr> <Tab> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : (pumvisible() ? '<C-n>' : '<Tab>')
snoremap <expr> <Tab> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'
inoremap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : (pumvisible() ? '<C-p>' : '<S-Tab>')
snoremap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'

# Buffer keybinds
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bd :bdelete<CR>
nnoremap <leader>q :bdelete<CR>
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

# Move up/down half a page
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz
inoremap <C-u> <C-o><C-u><C-o>zz
inoremap <C-d> <C-o><C-d><C-o>zz

# Center after searching
nnoremap n nzzzv
nnoremap N Nzzzv

# Clear search highlight
nnoremap <silent> <C-c> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>

# Toggle UndoTree
nnoremap <leader>u :UndotreeToggle<CR>

# fzf keybinds
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fg :GFiles<CR>
nnoremap <leader>fb :Lines<CR>
nnoremap <leader>fl :BLines<CR>
nnoremap <leader>fp :Rg<CR>
nnoremap <leader>fB :Buffers<CR>
nnoremap <leader>fw :Windows<CR>

# vim-fugitive keybind
nnoremap <leader>gs :Git<CR>

# Move selection up/down and indent
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

# Disable Q
nnoremap Q <NOP>

# Replace all instances of selected word
nnoremap <leader>s :%s/\<<C-r><C-w>\>//gI<Left><Left><Left>

# Make file executable
nnoremap <leader>x <CMD>!chmod +x %<CR>

# Delete in normal mode
nnoremap <Backspace> X
vnoremap <Backspace> x

# Resize windows
nnoremap <silent> <C-k> :resize -1<CR>
nnoremap <silent> <C-j> :resize +1<CR>
nnoremap <silent> <C-h> :vertical resize -1<CR>
nnoremap <silent> <C-l> :vertical resize +1<CR>

# Easy move through split windows
nnoremap <silent> <C-Up> :wincmd k<CR>
nnoremap <silent> <C-Down> :wincmd j<CR>
nnoremap <silent> <C-Left> :wincmd h<CR>
nnoremap <silent> <C-Right> :wincmd l<CR>

# Move cursor in insert mode
inoremap <expr> <C-k> pumvisible() ? '<C-p>' : '<Up>'
inoremap <expr> <C-j> pumvisible() ? '<C-n>' : '<Down>'
inoremap <C-h> <Left>
inoremap <C-l> <Right>

# Don't skip wrapped lines
nnoremap j gj
nnoremap gj j
nnoremap k gk
nnoremap gk k

# Terminal commands
nnoremap <leader>tt :terminal<CR>
nnoremap <leader>tr :terminal<Space>
nnoremap <leader>tmr :terminal make release<CR>
nnoremap <leader>tmd :terminal make debug<CR>
nnoremap <leader>tma :terminal make all<CR>
nnoremap <leader>tp :terminal python %<CR>
nnoremap <leader>ts :terminal ./%<CR>

# LSP Options
var lsp_opts = {
    aleSupport: false,
    autoComplete: false,
    autoHighlight: true,
    autoHighlightDiags: true,
    autoPopulateDiags: false,
    completionMatcher: 'fuzzy',
    completionMatcherValue: 1,
    diagSignErrorText: 'E>',
    diagSignHintText: 'H>',
    diagSignInfoText: 'I>',
    diagSignWarningText: 'W>',
    echoSignature: false,
    hideDisabledCodeActions: false,
    highlightDiagInline: true,
    hoverInPreview: false,
    ignoreMissingServer: true,
    keepFocusInDiags: true,
    keepFocusInReferences: true,
    completionTextEdit: true,
    diagVirtualTextAlign: 'above',
    diagVirtualTextWrap: 'default',
    noNewlineInCompletion: false,
    omniComplete: true,
    omniCompleteAllowBare: false,
    outlineOnRight: false,
    outlineWinSize: 20,
    popupBorder: true,
    popupBorderHighlight: 'Title',
    popupBorderHighlightPeek: 'Special',
    popupBorderSignatureHelp: false,
    popupHighlightSignatureHelp: 'Pmenu',
    popupHighlight: 'Normal',
    semanticHighlight: true,
    semanticHighlightDelay: 500,
    showDiagInBalloon: true,
    showDiagInPopup: true,
    showDiagOnStatusLine: true,
    showDiagWithSign: true,
    showDiagWithVirtualText: false,
    showInlayHints: false,
    showSignature: true,
    snippetSupport: false,
    ultisnipsSupport: false,
    useBufferCompletion: false,
    usePopupInCodeAction: false,
    useQuickfixForLocations: false,
    vsnipSupport: true,
    bufferCompletionTimeout: 100,
    customCompletionKinds: false,
    completionKinds: {},
    filterCompletionDuplicates: false,
    condensedCompletionMenu: false,
}
autocmd User LspSetup call LspOptionsSet(lsp_opts)

# LSP Servers
var lsp_servers = [
    {
        name: 'clang',
        filetype: ['c', 'cpp'],
        path: '/usr/bin/clangd',
        args: ['--background-index', '-j=4', '--clang-tidy', '--completion-style=detailed', '-header-insertion=never']
    },
    {
        name: 'ccls',
        filetype: ['c', 'cpp'],
        path: '/usr/bin/ccls',
        args: []
    },
    {
        name: 'python-lsp-server',
        filetype: ['python', 'py'],
        path: '/usr/bin/pylsp',
        args: []
    },
    {
        name: 'bash-language-server',
        filetype: ['sh'],
        path: '/usr/bin/bash-language-server',
        args: ['start']
    },
    {
        name: 'lua-language-server',
        filetype: ['lua'],
        path: '/usr/bin/lua-language-server',
        args: [],
        workspaceConfig: {
            Lua: {
                hit: { enable: true }
            }
        }
    }
]
autocmd User LspSetup call LspAddServer(lsp_servers)

# LSP Keybinds
nnoremap <leader>ca :LspCodeAction<CR>
nnoremap <leader>cl :LspCodeLens<CR>

nnoremap <leader>dc :LspDiag current<CR>
nnoremap <leader>df :LspDiag first<CR>
nnoremap <leader>dh :LspDiag here<CR>
nnoremap <leader>dd :LspDiag highlight toggle<CR>
nnoremap <leader>dn :LspDiag nextWrap<CR>
nnoremap <leader>dp :LspDiag prevWrap<CR>
nnoremap <leader>ds :LspDiag show<CR>

nnoremap <leader>gc :LspGotoDeclaration<CR>
nnoremap <leader>gd :LspGotoDefinition<CR>
nnoremap <leader>gi :LspGotoImpl<CR>
nnoremap <leader>gt :LspGotoTypeDef<CR>

nnoremap <leader>h :LspHover<CR>

nnoremap <leader>o :LspOutline<CR>

nnoremap <leader>pc :LspPeekDeclaration<CR>
nnoremap <leader>pd :LspPeekDefinition<CR>
nnoremap <leader>pi :LspPeekImpl<CR>
nnoremap <leader>pr :LspPeekReferences<CR>
nnoremap <leader>pt :LspPeekTypeDef<CR>

nnoremap <leader>` :LspSwitchSourceHeader<CR>

nnoremap <leader>/ :LspSymbolSearch<CR>

nnoremap <leader>ks :LspShowSignature<CR>

nnoremap <leader>wa :LspWorkspaceAddFolder<Space>
nnoremap <leader>wl :LspWorkspaceListFolders<CR>
nnoremap <leader>wd :LspWorkspaceRemoveFolder<Space>

