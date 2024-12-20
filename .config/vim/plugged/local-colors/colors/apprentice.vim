" Name:         apprentice
" Description:  Essentially a streamlining and conversion to xterm colors of 'sorcerer' by Jeet Sukumaran (jeetsukumaran@gmailcom)
" Author:       Romain Lafourcade <romainlafourcade@gmail.com>
" Maintainer:   Romain Lafourcade <romainlafourcade@gmail.com>
" Website:      https://github.com/romainl/Apprentice
" License:      MIT
" Last Updated: Tue Jul 30 09:29:33 2024

" Generated by Colortemplate v2.2.0

set background=dark

hi clear
let g:colors_name = 'apprentice'

let s:t_Co = exists('&t_Co') && !empty(&t_Co) && &t_Co > 1 ? &t_Co : 1

hi    Normal           ctermfg=NONE             ctermbg=NONE cterm=NONE
hi    CursorLineNr     ctermfg=NONE             ctermbg=236  cterm=NONE
hi    CursorLine       ctermfg=NONE             ctermbg=236  cterm=NONE
hi    NonText          ctermfg=240              ctermbg=NONE cterm=NONE
hi    EndOfBuffer      ctermfg=240              ctermbg=NONE cterm=NONE
hi    LineNr           ctermfg=10               ctermbg=NONE cterm=NONE
hi    FoldColumn       ctermfg=242              ctermbg=234  cterm=NONE
hi    Folded           ctermfg=242              ctermbg=234  cterm=NONE
hi    MatchParen       ctermfg=229              ctermbg=234  cterm=NONE
hi    SignColumn       ctermfg=242              ctermbg=234  cterm=NONE
hi    Pmenu            ctermfg=250              ctermbg=238  cterm=NONE
hi    PmenuSbar        ctermfg=NONE             ctermbg=240  cterm=NONE
hi    PmenuSel         ctermfg=249              ctermbg=236  cterm=NONE,reverse
hi    PmenuThumb       ctermfg=66               ctermbg=66   cterm=NONE
hi    ErrorMsg         ctermfg=131              ctermbg=235  cterm=reverse
hi    ModeMsg          ctermfg=NONE             ctermbg=NONE cterm=NONE
hi    MoreMsg          ctermfg=66               ctermbg=NONE cterm=NONE
hi    Question         ctermfg=108              ctermbg=NONE cterm=NONE
hi    WarningMsg       ctermfg=131              ctermbg=NONE cterm=NONE
hi    TabLine          ctermfg=101              ctermbg=238  cterm=NONE
hi    TabLineFill      ctermfg=238              ctermbg=238  cterm=NONE
hi    TabLineSel       ctermfg=235              ctermbg=101  cterm=NONE
hi    ToolbarLine      ctermfg=NONE             ctermbg=234  cterm=NONE
hi    ToolbarButton    ctermfg=250              ctermbg=240  cterm=NONE
hi    Cursor           ctermfg=235              ctermbg=250  cterm=NONE
hi    CursorColumn     ctermfg=NONE             ctermbg=236  cterm=NONE
hi    StatusLine       ctermfg=235              ctermbg=101  cterm=NONE
hi    StatusLineNC     ctermfg=101              ctermbg=238  cterm=NONE
hi    StatusLineTerm   ctermfg=235              ctermbg=101  cterm=NONE
hi    StatusLineTermNC ctermfg=101              ctermbg=238  cterm=NONE
"hi    Visual           ctermfg=110              ctermbg=235  cterm=reverse
"hi    VisualNOS        ctermfg=NONE             ctermbg=NONE cterm=underline
hi    VertSplit        ctermfg=238              ctermbg=238  cterm=NONE
hi    WildMenu         ctermfg=235              ctermbg=110  cterm=NONE
hi    DiffAdd          ctermfg=111              ctermbg=236  cterm=reverse
hi    DiffChange       ctermfg=188              ctermbg=236  cterm=reverse
hi    DiffDelete       ctermfg=222              ctermbg=236  cterm=reverse
hi    DiffText         ctermfg=145              ctermbg=236  cterm=reverse
"hi    IncSearch        ctermfg=235              ctermbg=131  cterm=NONE
"hi    Search           ctermfg=235              ctermbg=229  cterm=NONE
hi    Directory        ctermfg=73               ctermbg=NONE cterm=NONE
hi    debugPC          ctermfg=NONE             ctermbg=67   cterm=NONE
hi    debugBreakpoint  ctermfg=NONE             ctermbg=131  cterm=NONE
hi    SpellBad         ctermfg=131              ctermbg=NONE cterm=undercurl
hi    SpellCap         ctermfg=73               ctermbg=NONE cterm=undercurl
hi    SpellLocal       ctermfg=65               ctermbg=NONE cterm=undercurl
hi    SpellRare        ctermfg=208              ctermbg=NONE cterm=undercurl
hi    ColorColumn      ctermfg=NONE             ctermbg=234  cterm=NONE
hi    Terminal         ctermfg=NONE             ctermbg=NONE cterm=NONE
hi    Comment          ctermfg=242              ctermbg=NONE cterm=NONE
hi    Conceal          ctermfg=250              ctermbg=NONE cterm=NONE
hi    Constant         ctermfg=208              ctermbg=NONE cterm=NONE
hi    Error            ctermfg=131              ctermbg=NONE cterm=reverse
hi    Identifier       ctermfg=67               ctermbg=NONE cterm=NONE
hi    Ignore           ctermfg=NONE             ctermbg=NONE cterm=NONE
hi    PreProc          ctermfg=66               ctermbg=NONE cterm=NONE
hi    Special          ctermfg=65               ctermbg=NONE cterm=NONE
hi    Statement        ctermfg=110              ctermbg=NONE cterm=NONE
hi    String           ctermfg=108              ctermbg=NONE cterm=NONE
hi    Todo             ctermfg=NONE             ctermbg=NONE cterm=reverse
hi    Type             ctermfg=103              ctermbg=NONE cterm=NONE
hi    Underlined       ctermfg=66               ctermbg=NONE cterm=underline
hi    Function         ctermfg=229              ctermbg=NONE cterm=NONE
hi    SpecialKey       ctermfg=59               ctermbg=237  cterm=NONE
hi    Title            ctermfg=NONE             ctermbg=NONE cterm=NONE
hi    helpLeadBlank    ctermfg=NONE             ctermbg=NONE cterm=NONE
hi    helpNormal       ctermfg=NONE             ctermbg=NONE cterm=NONE
hi!   link             Number                   Constant
hi!   link             Boolean                  Constant
hi!   link             Character                Constant
hi!   link             Conditional              Statement
hi!   link             Debug                    Special
hi!   link             Define                   PreProc
hi!   link             Delimiter                Special
hi!   link             Exception                Statement
hi!   link             Float                    Number
hi!   link             Include                  PreProc
hi!   link             Keyword                  Statement
hi!   link             Label                    Statement
hi!   link             Macro                    PreProc
hi!   link             Operator                 Statement
hi!   link             PreCondit                PreProc
hi!   link             Repeat                   Statement
hi!   link             SpecialChar              Special
hi!   link             SpecialComment           Special
hi!   link             StorageClass             Type
hi!   link             Structure                Type
hi!   link             Tag                      Special
hi!   link             Typedef                  Type
hi!   link             HelpCommand              Statement
hi!   link             HelpExample              Statement
hi!   link             htmlTagName              Statement
hi!   link             htmlEndTag               htmlTagName
hi!   link             htmlLink                 Function
hi!   link             htmlSpecialTagName       htmlTagName
hi!   link             htmlTag                  htmlTagName
hi!   link             htmlBold                 Normal
hi!   link             htmlItalic               Normal
hi!   link             htmlArg                  htmlTagName
hi!   link             xmlTag                   Statement
hi!   link             xmlTagName               Statement
hi!   link             xmlEndTag                Statement
hi!   link             markdownItalic           Preproc
hi!   link             asciidocQuotedEmphasized Preproc
unlet s:t_Co
finish

