" Name:         habamax
" Description:  Hubba hubba hubba.
" Author:       Maxim Kim <habamax@gmail.com>
" Maintainer:   Maxim Kim <habamax@gmail.com>
" Website:      https://github.com/vim/colorschemes
" License:      Same as Vim
" Last Change:  2024 Aug 15

" Generated by Colortemplate v2.2.3

set background=dark

hi clear

let g:colors_name = 'habamin'

hi! link            Terminal             Normal
hi! link            StatuslineTerm       Statusline
hi! link            StatuslineTermNC     StatuslineNC
hi! link            MessageWindow        Pmenu
hi! link            javaScriptFunction   Statement
hi! link            javaScriptIdentifier Statement
hi! link            sqlKeyword           Statement
hi! link            yamlBlockMappingKey  Statement
hi! link            rubyMacro            Statement
hi! link            rubyDefine           Statement
hi! link            vimVar               Normal
hi! link            vimOper              Normal
hi! link            vimSep               Normal
hi! link            vimParenSep          Normal
hi! link            vimCommentString     Comment
hi! link            markdownUrl          String
hi  Normal          ctermfg=NONE         ctermbg=NONE cterm=NONE
hi  Statusline      ctermfg=234          ctermbg=247  cterm=NONE
hi  StatuslineNC    ctermfg=234          ctermbg=243  cterm=NONE
hi  VertSplit       ctermfg=243          ctermbg=243  cterm=NONE
hi  TabLine         ctermfg=234          ctermbg=243  cterm=NONE
hi  TabLineFill     ctermfg=234          ctermbg=243  cterm=NONE
hi  TabLineSel      ctermfg=234          ctermbg=247  cterm=bold
hi  ToolbarLine     ctermfg=NONE         ctermbg=NONE cterm=NONE
hi  ToolbarButton   ctermfg=243          ctermbg=234  cterm=bold,reverse
hi  QuickFixLine    ctermfg=234          ctermbg=67   cterm=NONE
hi  CursorLineNr    ctermfg=253          ctermbg=NONE cterm=bold
hi  LineNr          ctermfg=240          ctermbg=NONE cterm=NONE
hi  LineNrAbove     ctermfg=240          ctermbg=NONE cterm=NONE
hi  LineNrBelow     ctermfg=240          ctermbg=NONE cterm=NONE
hi  NonText         ctermfg=240          ctermbg=NONE cterm=NONE
hi  EndOfBuffer     ctermfg=240          ctermbg=NONE cterm=NONE
hi  SpecialKey      ctermfg=240          ctermbg=NONE cterm=NONE
hi  FoldColumn      ctermfg=240          ctermbg=NONE cterm=NONE
"hi  Visual          ctermfg=109          ctermbg=234  cterm=reverse
"hi  VisualNOS       ctermfg=234          ctermbg=66   cterm=NONE
hi  Pmenu           ctermfg=NONE         ctermbg=237  cterm=NONE
hi  PmenuThumb      ctermfg=NONE         ctermbg=243  cterm=NONE
hi  PmenuSbar       ctermfg=NONE         ctermbg=NONE cterm=NONE
hi  PmenuSel        ctermfg=NONE         ctermbg=240  cterm=NONE
hi  PmenuKind       ctermfg=66           ctermbg=237  cterm=NONE
hi  PmenuKindSel    ctermfg=66           ctermbg=240  cterm=NONE
hi  PmenuExtra      ctermfg=243          ctermbg=237  cterm=NONE
hi  PmenuExtraSel   ctermfg=247          ctermbg=240  cterm=NONE
hi  PmenuMatch      ctermfg=215          ctermbg=237  cterm=NONE
hi  PmenuMatchSel   ctermfg=215          ctermbg=240  cterm=NONE
hi  SignColumn      ctermfg=NONE         ctermbg=NONE cterm=NONE
hi  Error           ctermfg=131          ctermbg=234  cterm=reverse
hi  ErrorMsg        ctermfg=131          ctermbg=234  cterm=reverse
hi  ModeMsg         ctermfg=NONE         ctermbg=NONE cterm=bold
hi  MoreMsg         ctermfg=71           ctermbg=NONE cterm=NONE
hi  Question        ctermfg=180          ctermbg=NONE cterm=NONE
hi  WarningMsg      ctermfg=168          ctermbg=NONE cterm=NONE
hi  Todo            ctermfg=253          ctermbg=NONE cterm=bold
hi  MatchParen      ctermfg=199          ctermbg=NONE cterm=bold
"hi  Search          ctermfg=74           ctermbg=234  cterm=reverse
"hi  IncSearch       ctermfg=215          ctermbg=234  cterm=reverse
"hi  CurSearch       ctermfg=215          ctermbg=234  cterm=reverse
hi  WildMenu        ctermfg=234          ctermbg=180  cterm=bold
hi  debugPC         ctermfg=234          ctermbg=67   cterm=NONE
hi  debugBreakpoint ctermfg=234          ctermbg=168  cterm=NONE
hi  CursorLine      ctermfg=NONE         ctermbg=236  cterm=NONE
hi  CursorColumn    ctermfg=NONE         ctermbg=236  cterm=NONE
hi  Folded          ctermfg=247          ctermbg=235  cterm=NONE
hi  ColorColumn     ctermfg=NONE         ctermbg=237  cterm=NONE
hi  SpellBad        ctermfg=167          ctermbg=NONE cterm=underline
hi  SpellCap        ctermfg=215          ctermbg=NONE cterm=underline
hi  SpellLocal      ctermfg=77           ctermbg=NONE cterm=underline
hi  SpellRare       ctermfg=176          ctermbg=NONE cterm=underline
hi  Comment         ctermfg=243          ctermbg=NONE cterm=NONE
hi  Constant        ctermfg=168          ctermbg=NONE cterm=NONE
hi  String          ctermfg=71           ctermbg=NONE cterm=NONE
hi  Character       ctermfg=114          ctermbg=NONE cterm=NONE
hi  Identifier      ctermfg=109          ctermbg=NONE cterm=NONE
hi  Statement       ctermfg=139          ctermbg=NONE cterm=NONE
hi  PreProc         ctermfg=137          ctermbg=NONE cterm=NONE
hi  Type            ctermfg=67           ctermbg=NONE cterm=NONE
hi  Special         ctermfg=66           ctermbg=NONE cterm=NONE
hi  Underlined      ctermfg=NONE         ctermbg=NONE cterm=underline
hi  Title           ctermfg=NONE         ctermbg=NONE cterm=bold
hi  Directory       ctermfg=109          ctermbg=NONE cterm=bold
hi  Conceal         ctermfg=240          ctermbg=NONE cterm=NONE
hi  Ignore          ctermfg=NONE         ctermbg=NONE cterm=NONE
hi  Debug           ctermfg=66           ctermbg=NONE cterm=NONE
hi  DiffAdd         ctermfg=71           ctermbg=NONE cterm=reverse
hi  DiffChange      ctermfg=67           ctermbg=NONE cterm=reverse
hi  DiffText        ctermfg=139          ctermbg=NONE cterm=reverse
hi  DiffDelete      ctermfg=131          ctermbg=NONE cterm=reverse
hi  Added           ctermfg=77           ctermbg=NONE cterm=NONE
hi  Changed         ctermfg=215          ctermbg=NONE cterm=NONE
hi  Removed         ctermfg=167          ctermbg=NONE cterm=NONE

finish
