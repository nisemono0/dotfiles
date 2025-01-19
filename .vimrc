vim9script

# Plugins
set rtp+=~/.config/vim/
plug#begin('~/.config/vim/plugged')
    # Web
    Plug 'preservim/nerdtree'
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
    Plug 'girishji/vimcomplete'
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
#    1 -> blinking block
#    2 -> solid block
#    3 -> blinking underscore
#    4 -> solid underscore
#    5 -> blinking vertical bar
#    6 -> solid vertical bar
&t_SI = "\<Esc>[6 q"
&t_SR = "\<Esc>[4 q"
&t_EI = "\<Esc>[2 q"

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

# Highlight yank
b:highlightedyank_highlight_duration = 50
g:highlightedyank_highlight_in_visual = 0

# Show registers
nnoremap <leader>r :registers<CR>

# Toggle NerdTree
nnoremap <C-n> :NERDTreeToggle<CR>

# Completion window
inoremap <C-@> <C-n>
inoremap <C-Space> <C-n>
inoremap <expr> <Tab> pumvisible() ? '<C-n>' : '<Tab>'
inoremap <expr> <S-Tab> pumvisible() ? '<C-p>' : '<S-Tab>'
inoremap <expr> <Enter> pumvisible() ? (complete_info().selected == -1 ? '<C-y><CR>' : '<C-y>') : '<CR>'

# Buffer keybinds
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bd :bdelete<CR>
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
inoremap <C-k> <Up>
inoremap <C-j> <Down>
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

# vimcomplete
var vimcomplete_opts = {
    completor: {
        shuffleEqualPriority: true,
        kindDisplayType: "text"
    },
    buffer: {
        urlComplete: true,
        envComplete: true
    },
    vsnip: {
        enable: true,
        priority: 11
    },
    vimscript: {
        enable: true,
        priority: 11
    }
}
autocmd VimEnter * g:VimCompleteOptionsSet(vimcomplete_opts)
nnoremap <leader>ae :VimCompleteEnable<CR>
nnoremap <leader>ad :VimCompleteDisable<CR>

# LSP Options
var lsp_opts = {
    aleSupport: v:false,
    autoComplete: v:true,
    autoHighlight: v:false,
    autoHighlightDiags: v:true,
    autoPopulateDiags: v:false,
    completionMatcher: 'case',
    completionMatcherValue: 1,
    diagSignErrorText: 'E>',
    diagSignHintText: 'H>',
    diagSignInfoText: 'I>',
    diagSignWarningText: 'W>',
    echoSignature: v:false,
    hideDisabledCodeActions: v:false,
    highlightDiagInline: v:true,
    hoverInPreview: v:false,
    ignoreMissingServer: v:true,
    keepFocusInDiags: v:true,
    keepFocusInReferences: v:true,
    completionTextEdit: v:true,
    diagVirtualTextAlign: 'above',
    diagVirtualTextWrap: 'default',
    noNewlineInCompletion: v:false,
    omniComplete: v:null,
    outlineOnRight: v:false,
    outlineWinSize: 20,
    semanticHighlight: v:true,
    showDiagInBalloon: v:true,
    showDiagInPopup: v:true,
    showDiagOnStatusLine: v:true,
    showDiagWithSign: v:true,
    showDiagWithVirtualText: v:false,
    showInlayHints: v:false,
    showSignature: v:true,
    snippetSupport: v:false,
    ultisnipsSupport: v:false,
    useBufferCompletion: v:false,
    usePopupInCodeAction: v:false,
    useQuickfixForLocations: v:false,
    vsnipSupport: v:true,
    bufferCompletionTimeout: 100,
    customCompletionKinds: v:false,
    completionKinds: {},
    filterCompletionDuplicates: v:false
}
autocmd User LspSetup call LspOptionsSet(lsp_opts)

# LSP Servers
var lsp_servers = [
    {
        name: 'clang',
        filetype: ['c', 'cpp'],
        path: '/usr/bin/clangd',
        args: ['--background-index']
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
    },
    {
        name: 'dart',
        filetype: ['dart'],
        path: '/usr/bin/dart',
        args: ['language-server', '--client-id', 'vim']
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

nnoremap <leader>wa :LspWorkspaceAddFolder<Space>
nnoremap <leader>wl :LspWorkspaceListFolders<CR>
nnoremap <leader>wd :LspWorkspaceRemoveFolder<Space>

