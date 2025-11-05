" Vim colorscheme
" Author: Anmol Mathias <anmolmathias@gmail.com>
" URL: https://github.com/anmolmathias/vim-colors-alabaster
" Notes: Adapted from the Alabaster sublime scheme by Nikita Prokopov
" License: MIT

set background=dark
highlight clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name="Alabaster Dark"

"------------------------------------------------------------
" -- local      -- vim           -- iterm2         -- tonsky
"------------------------------------------------------------
let s:none      = "none"
let s:black     = "black"        " normal black    -- #000000
let s:white     = "lightgray"    " bright white    -- #ffffff
let s:magenta   = "magenta"      " bright magenta  -- #f9e0ff
let s:yellow    = "yellow"       " bright yellow   -- #fffabc
let s:red       = "darkred"      " normal red      -- #ffe0e0
let s:orange    = "red"          " bright red      -- #ffbc5d
let s:blue      = "blue"         " bright blue     -- #dbf1ff
let s:cyan      = "cyan"         " bright cyan     -- #dbecb6
let s:green     = "green"        " bright green    -- #f1fadf
let s:darkgreen = "darkgreen"    " normal green    -- #dbecb6

" --------------------------------
" Editor settings
" --------------------------------
exe "hi! Normal"          "ctermfg=".s:white  "ctermbg=".s:none  "cterm=".s:none
exe "hi! Cursor"          "ctermfg=".s:none   "ctermbg=".s:none  "cterm=".s:none
exe "hi! CursorLine"      "ctermfg=".s:none   "ctermbg=".s:none  "cterm=".s:none
exe "hi! LineNr"          "ctermfg=".s:none   "ctermbg=".s:none  "cterm=".s:none
exe "hi! CursorLineNR"    "ctermfg=".s:none   "ctermbg=".s:none  "cterm=".s:none

" -----------------
" - Number column -
" -----------------
exe "hi! CursorColumn"    "ctermfg=".s:none  "ctermbg=".s:none  "cterm=".s:none
exe "hi! FoldColumn"      "ctermfg=".s:none  "ctermbg=".s:none  "cterm=".s:none
exe "hi! SignColumn"      "ctermfg=".s:none  "ctermbg=".s:none  "cterm=".s:none
exe "hi! Folded"          "ctermfg=".s:none  "ctermbg=".s:none  "cterm=".s:none

" -------------------------
" - Window/Tab delimiters -
" -------------------------
exe "hi! VertSplit"    "ctermfg=".s:magenta  "ctermbg=".s:none  "cterm=".s:none
exe "hi! ColorColumn"  "ctermfg=".s:magenta  "ctermbg=".s:none  "cterm=".s:none
exe "hi! TabLine"      "ctermfg=".s:magenta  "ctermbg=".s:none  "cterm=".s:none
exe "hi! TabLineFill"  "ctermfg=".s:magenta  "ctermbg=".s:none  "cterm=".s:none
exe "hi! TabLineSel"   "ctermfg=".s:cyan     "ctermbg=".s:none  "cterm=".s:none

" -------------------------------
" - File Navigation / Searching -
" -------------------------------
exe "hi! Directory"   "ctermfg=".s:none    "ctermbg=".s:none  "cterm=".s:none
" exe "hi! Search"      "ctermfg=".s:orange  "ctermbg=".s:none  "cterm=".s:none
" exe "hi! IncSearch"   "ctermfg=".s:orange  "ctermbg=".s:none  "cterm=".s:none

" -----------------
" - Prompt/Status -
" -----------------
exe "hi! StatusLine"    "ctermfg=".s:magenta  "ctermbg=".s:none  "cterm=".s:none
exe "hi! StatusLineNC"  "ctermfg=".s:magenta  "ctermbg=".s:none  "cterm=".s:none
exe "hi! WildMenu"      "ctermfg=".s:none     "ctermbg=".s:none  "cterm=".s:none
exe "hi! Quesion"       "ctermfg=".s:none     "ctermbg=".s:none  "cterm=".s:none
exe "hi! Title"         "ctermfg=".s:magenta  "ctermbg=".s:none  "cterm=".s:none
exe "hi! ModeMsg"       "ctermfg=".s:none     "ctermbg=".s:none  "cterm=".s:none
exe "hi! MoreMsg"       "ctermfg=".s:none     "ctermbg=".s:none  "cterm=".s:none

" --------------
" - Visual aid -
" --------------
" exe "hi! MatchParen"  "ctermfg=".s:blue  "ctermbg=".s:none  "cterm=".s:none
exe "hi! MatchParen"  "ctermfg=252"  "ctermbg=240" "cterm=bold"
" exe "hi! Visual"      "ctermfg=".s:cyan  "ctermbg=".s:none  "cterm=".s:none
" exe "hi! VisualNOS"   "ctermfg=".s:cyan  "ctermbg=".s:none  "cterm=".s:none
exe "hi! NonText"     "ctermfg=".s:none  "ctermbg=".s:none  "cterm=".s:none

exe "hi! Todo"        "ctermfg=".s:yellow  "ctermbg=".s:none   "cterm=bold,reverse"
exe "hi! Underlined"  "ctermfg=".s:none    "ctermbg=".s:none   "cterm=".s:none
exe "hi! Error"       "ctermfg=".s:red     "ctermbg=".s:black  "cterm=".s:none
exe "hi! ErrorMsg"    "ctermfg=".s:black   "ctermbg=".s:red    "cterm=".s:none
exe "hi! WarningMsg"  "ctermfg=".s:yellow  "ctermbg=".s:black  "cterm=".s:none
exe "hi! Ignore"      "ctermfg=".s:none    "ctermbg=".s:none   "cterm=".s:none
" exe "hi! SpecialKey"  "ctermfg=".s:none    "ctermbg=".s:none   "cterm=".s:none
exe "hi! SpecialKey"  "ctermfg=59"         "ctermbg=237"       "cterm=".s:none

" ------------------
" - Variable types -
" ------------------
exe "hi! Constant"        "ctermfg=".s:none       "ctermbg=".s:none  "cterm=".s:none
exe "hi! String"          "ctermfg=".s:darkgreen  "ctermbg=".s:none  "cterm=".s:none
exe "hi! StringDelimiter" "ctermfg=".s:darkgreen  "ctermbg=".s:none  "cterm=".s:none
exe "hi! Character"       "ctermfg=".s:magenta    "ctermbg=".s:none  "cterm=".s:none
exe "hi! Number"          "ctermfg=".s:magenta    "ctermbg=".s:none  "cterm=".s:none
exe "hi! Boolean"         "ctermfg=".s:magenta    "ctermbg=".s:none  "cterm=".s:none
exe "hi! Float"           "ctermfg=".s:magenta    "ctermbg=".s:none  "cterm=".s:none

exe "hi! Identifier"      "ctermfg=".s:blue  "ctermbg=".s:none  "cterm=".s:none
exe "hi! Function"        "ctermfg=".s:blue  "ctermbg=".s:none  "cterm=".s:none



" -----------------------
" - Language constructs -
" -----------------------
exe "hi! Statement"       "ctermfg=".s:none  "ctermbg=".s:none  "cterm=".s:none
exe "hi! Conditional"     "ctermfg=".s:none  "ctermbg=".s:none  "cterm=".s:none
exe "hi! Repeat"          "ctermfg=".s:none  "ctermbg=".s:none  "cterm=".s:none
exe "hi! Label"           "ctermfg=".s:none  "ctermbg=".s:none  "cterm=".s:none
exe "hi! Operator"        "ctermfg=".s:none  "ctermbg=".s:none  "cterm=".s:none
exe "hi! Keyword"         "ctermfg=".s:none  "ctermbg=".s:none  "cterm=".s:none
exe "hi! Exception"       "ctermfg=".s:red   "ctermbg=".s:none  "cterm=".s:none
exe "hi! Comment"         "ctermfg=".s:red   "ctermbg=".s:none  "cterm=".s:none

exe "hi! Special"         "ctermfg=".s:green  "ctermbg=".s:none  "cterm=".s:none
exe "hi! SpecialChar"     "ctermfg=".s:green  "ctermbg=".s:none  "cterm=".s:none
exe "hi! Tag"             "ctermfg=".s:none   "ctermbg=".s:none  "cterm=".s:none
exe "hi! Delimiter"       "ctermfg=".s:none   "ctermbg=".s:none  "cterm=".s:none
exe "hi! SpecialComment"  "ctermfg=".s:none   "ctermbg=".s:none  "cterm=".s:none
exe "hi! Debug"           "ctermfg=".s:none   "ctermbg=".s:none  "cterm=".s:none

" ----------
" - C like -
" ----------
exe "hi! PreProc"         "ctermfg=".s:none  "ctermbg=".s:none  "cterm=".s:none
exe "hi! Include"         "ctermfg=".s:none  "ctermbg=".s:none  "cterm=".s:none
exe "hi! Define"          "ctermfg=".s:none  "ctermbg=".s:none  "cterm=".s:none
exe "hi! Macro"           "ctermfg=".s:none  "ctermbg=".s:none  "cterm=".s:none
exe "hi! PreCondit"       "ctermfg=".s:none  "ctermbg=".s:none  "cterm=".s:none

exe "hi! Type"            "ctermfg=".s:none  "ctermbg=".s:none  "cterm=".s:none
exe "hi! StorageClass"    "ctermfg=".s:none  "ctermbg=".s:none  "cterm=".s:none
exe "hi! Structure"       "ctermfg=".s:none  "ctermbg=".s:none  "cterm=".s:none
exe "hi! Typedef"         "ctermfg=".s:none  "ctermbg=".s:none  "cterm=".s:none

" --------
" - Diff -
" --------
" exe "hi! DiffAdd"         "ctermfg=".s:none  "ctermbg=".s:none  "cterm=".s:none
exe "hi! DiffAdd"         "ctermfg=108"      "ctermbg=236"      "cterm=none,reverse"
" exe "hi! DiffAdd"         "ctermfg=255"      "ctermbg=64"      "cterm=bold"
" exe "hi! DiffChange"      "ctermfg=".s:none  "ctermbg=".s:none  "cterm=".s:none
exe "hi! DiffChange"      "ctermfg=".s:none  "ctermbg=237"      "cterm=".s:none
" exe "hi! DiffChange"      "ctermfg=137"  "ctermbg=236"      "cterm=".s:none
" exe "hi! DiffDelete"      "ctermfg=".s:none  "ctermbg=".s:none  "cterm=".s:none
exe "hi! DiffDelete"      "ctermfg=138"      "ctermbg=236"      "cterm=NONE,reverse"
" exe "hi! DiffDelete"      "ctermfg=236"      "ctermbg=167"      "cterm=NONE"
" exe "hi! DiffText"        "ctermfg=".s:none  "ctermbg=".s:none  "cterm=".s:none
exe "hi! DiffText"        "ctermfg=137"      "ctermbg=236"      "cterm=NONE,reverse"

" -------------------
" - Completion menu -
" -------------------
" exe "hi! Pmenu"           "ctermfg=".s:none  "ctermbg=".s:green "cterm=".s:none
exe "hi! Pmenu"           "ctermfg=".s:none  "ctermbg=237" "cterm=".s:none
exe "hi! PmenuSel"        "ctermfg=".s:none  "ctermbg=".s:red  "cterm=".s:none
" exe "hi! PmenuSbar"       "ctermfg=".s:black "ctermbg=".s:white "cterm=".s:none
exe "hi! PmenuSbar"       "ctermfg=240"      "ctermbg=240"      "cterm=".s:none
" exe "hi! PmenuKind"       "ctermfg=".s:cyan  "ctermbg=".s:green "cterm=".s:none
exe "hi! PmenuKind"       "ctermfg=".s:cyan  "ctermbg=237" "cterm=".s:none
" exe "hi! PmenuKindSel"    "ctermfg=".s:cyan  "ctermbg=".s:blue  "cterm=".s:none
exe "hi! PmenuKindSel"    "ctermfg=".s:cyan  "ctermbg=".s:red  "cterm=".s:none
" exe "hi! PmenuThumb"      "ctermfg=".s:none  "ctermbg=".s:none  "cterm=".s:none
exe "hi! PmenuThumb"      "ctermfg=249"      "ctermbg=249"      "cterm=".s:none
exe "hi! PmenuMatch"      "ctermfg=".s:none  "ctermbg=".s:none  "cterm=bold,underline"
exe "hi! PmenuMatchSel"   "ctermfg=".s:none  "ctermbg=".s:none  "cterm=bold,underline"

" ------------
" - Spelling -
" ------------
exe "hi! SpellBad"        "ctermfg=".s:red  "ctermbg=".s:none  "cterm=underline,reverse"
exe "hi! SpellCap"        "ctermfg=".s:red  "ctermbg=".s:none  "cterm=underline,reverse"
exe "hi! SpellLocal"      "ctermfg=".s:red  "ctermbg=".s:none  "cterm=underline,reverse"
exe "hi! SpellRare"       "ctermfg=".s:red  "ctermbg=".s:none  "cterm=underline,reverse"

exe "hi! jsVariableDef"   "ctermfg=".s:blue     "ctermbg=".s:none  "cterm=".s:none
exe "hi! clojureKeyword"  "ctermfg=".s:magenta  "ctermbg=".s:none  "cterm=".s:none
exe "hi! clojureSpecial"  "ctermfg=".s:none     "ctermbg=".s:none  "cterm=".s:none
exe "hi! clojureVarArg"   "ctermfg=".s:none     "ctermbg=".s:none  "cterm=".s:none
