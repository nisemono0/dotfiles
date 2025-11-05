" Name:         snow
" Author:       nightsense
" Maintainer:   nightsense
" License:      MIT

if !(has('termguicolors') && &termguicolors) && !has('gui_running')
    \ && (!exists('&t_Co') || &t_Co < 256)
  echoerr '[snow] There are not enough colors.'
  finish
endif

hi clear
if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'snow'

hi Bold             ctermfg=NONE ctermbg=NONE guifg=NONE    guibg=NONE    guisp=NONE    cterm=NONE,bold      gui=NONE,bold
hi Conceal          ctermfg=NONE ctermbg=NONE guifg=NONE    guibg=NONE    guisp=NONE    cterm=NONE           gui=NONE
hi Directory        ctermfg=NONE ctermbg=NONE guifg=NONE    guibg=NONE    guisp=NONE    cterm=NONE,bold      gui=NONE,bold
hi EndOfBuffer      ctermfg=NONE ctermbg=NONE guifg=NONE    guibg=NONE    guisp=NONE    cterm=NONE           gui=NONE
hi Ignore           ctermfg=NONE ctermbg=NONE guifg=NONE    guibg=NONE    guisp=NONE    cterm=NONE           gui=NONE
hi Italic           ctermfg=NONE ctermbg=NONE guifg=NONE    guibg=NONE    guisp=NONE    cterm=NONE,italic    gui=NONE,italic
hi ModeMsg          ctermfg=NONE ctermbg=NONE guifg=NONE    guibg=NONE    guisp=NONE    cterm=NONE           gui=NONE
hi MoreMsg          ctermfg=NONE ctermbg=NONE guifg=NONE    guibg=NONE    guisp=NONE    cterm=NONE           gui=NONE
hi Question         ctermfg=NONE ctermbg=NONE guifg=NONE    guibg=NONE    guisp=NONE    cterm=NONE           gui=NONE
hi NonText          ctermfg=NONE ctermbg=NONE guifg=NONE    guibg=NONE    guisp=NONE    cterm=NONE           gui=NONE
hi Normal           ctermfg=NONE ctermbg=NONE guifg=NONE    guibg=NONE    guisp=NONE    cterm=NONE           gui=NONE
hi Terminal         ctermfg=NONE ctermbg=NONE guifg=NONE    guibg=NONE    guisp=NONE    cterm=NONE           gui=NONE
hi Title            ctermfg=NONE ctermbg=NONE guifg=NONE    guibg=NONE    guisp=NONE    cterm=NONE,bold      gui=NONE,bold
hi Underlined       ctermfg=NONE ctermbg=NONE guifg=NONE    guibg=NONE    guisp=NONE    cterm=NONE,underline gui=NONE,underline
hi Comment          ctermfg=246  ctermbg=NONE guifg=#8c95a0 guibg=NONE    guisp=NONE    cterm=NONE           gui=NONE
hi CursorLineNr     ctermfg=246  ctermbg=255  guifg=#8c95a0 guibg=NONE    guisp=NONE    cterm=NONE           gui=NONE
hi LineNr           ctermfg=10   ctermbg=NONE guifg=#8c95a0 guibg=NONE    guisp=NONE    cterm=NONE           gui=NONE
hi FoldColumn       ctermfg=249  ctermbg=NONE guifg=#afb7c0 guibg=NONE    guisp=NONE    cterm=NONE           gui=NONE
hi PmenuSel         ctermfg=249  ctermbg=236  guifg=#afb7c0 guibg=#2c2d30 guisp=NONE    cterm=NONE,reverse   gui=NONE,reverse
hi PmenuMatch       ctermfg=NONE ctermbg=NONE                                           cterm=bold,underline
hi PmenuMatchSel    ctermfg=NONE ctermbg=NONE                                           cterm=bold,underline
hi SignColumn       ctermfg=249  ctermbg=NONE guifg=#afb7c0 guibg=NONE    guisp=NONE    cterm=NONE           gui=NONE
hi StatusLine       ctermfg=249  ctermbg=236  guifg=#afb7c0 guibg=#2c2d30 guisp=NONE    cterm=NONE,reverse   gui=NONE,reverse
hi StatusLineTerm   ctermfg=249  ctermbg=236  guifg=#afb7c0 guibg=#2c2d30 guisp=NONE    cterm=NONE,reverse   gui=NONE,reverse
hi TabLineSel       ctermfg=249  ctermbg=236  guifg=#afb7c0 guibg=#2c2d30 guisp=NONE    cterm=NONE,reverse   gui=NONE,reverse
hi Cursor           ctermfg=252  ctermbg=236  guifg=#cbd2d9 guibg=#2c2d30 guisp=NONE    cterm=NONE,reverse   gui=NONE,reverse
"hi IncSearch        ctermfg=252  ctermbg=236  guifg=#cbd2d9 guibg=#2c2d30 guisp=NONE    cterm=NONE,reverse   gui=NONE,reverse
hi ColorColumn      ctermfg=NONE ctermbg=237  guifg=NONE    guibg=#363a3e guisp=NONE    cterm=NONE           gui=NONE
hi CursorColumn     ctermfg=NONE ctermbg=237  guifg=NONE    guibg=#363a3e guisp=NONE    cterm=NONE           gui=NONE
hi CursorLine       ctermfg=NONE ctermbg=237  guifg=NONE    guibg=#363a3e guisp=NONE    cterm=NONE           gui=NONE
hi DiffChange       ctermfg=NONE ctermbg=237  guifg=NONE    guibg=#363a3e guisp=NONE    cterm=NONE           gui=NONE
hi DiffChanged      ctermfg=NONE ctermbg=237  guifg=NONE    guibg=#363a3e guisp=NONE    cterm=NONE           gui=NONE
" hi DiffChange       ctermfg=137  ctermbg=236  guifg=NONE    guibg=#363a3e guisp=NONE    cterm=NONE           gui=NONE
" hi DiffChanged      ctermfg=137  ctermbg=236  guifg=NONE guibg=#2c2d30 guisp=NONE    cterm=NONE           gui=NONE
hi Folded           ctermfg=NONE ctermbg=237  guifg=NONE    guibg=#363a3e guisp=NONE    cterm=NONE           gui=NONE
hi MatchParen       ctermfg=252  ctermbg=240  guifg=#cbd2d9 guibg=#535c65 guisp=NONE    cterm=bold           gui=NONE
hi Pmenu            ctermfg=249  ctermbg=237  guifg=#afb7c0 guibg=#363a3e guisp=NONE    cterm=NONE           gui=NONE
hi StatusLineNC     ctermfg=249  ctermbg=237  guifg=#afb7c0 guibg=#363a3e guisp=NONE    cterm=NONE           gui=NONE
hi StatusLineTermNC ctermfg=249  ctermbg=237  guifg=#afb7c0 guibg=#363a3e guisp=NONE    cterm=NONE           gui=NONE
hi TabLine          ctermfg=249  ctermbg=237  guifg=#afb7c0 guibg=#363a3e guisp=NONE    cterm=NONE           gui=NONE
hi ToolbarButton    ctermfg=249  ctermbg=237  guifg=#afb7c0 guibg=#363a3e guisp=NONE    cterm=NONE,bold      gui=NONE,bold
hi WildMenu         ctermfg=249  ctermbg=237  guifg=#afb7c0 guibg=#363a3e guisp=NONE    cterm=NONE           gui=NONE
hi PmenuSbar        ctermfg=240  ctermbg=240  guifg=#535c65 guibg=#535c65 guisp=NONE    cterm=NONE           gui=NONE
hi PmenuThumb       ctermfg=249  ctermbg=249  guifg=#afb7c0 guibg=#afb7c0 guisp=NONE    cterm=NONE           gui=NONE
hi TabLineFill      ctermfg=237  ctermbg=237  guifg=#363a3e guibg=#363a3e guisp=NONE    cterm=NONE           gui=NONE
hi ToolbarLine      ctermfg=237  ctermbg=237  guifg=#363a3e guibg=#363a3e guisp=NONE    cterm=NONE           gui=NONE
hi VertSplit        ctermfg=240  ctermbg=240  guifg=#535c65 guibg=#535c65 guisp=NONE    cterm=NONE           gui=NONE
hi SpellBad         ctermfg=167  ctermbg=NONE guifg=NONE    guibg=NONE    guisp=#df969e cterm=NONE,underline gui=NONE,undercurl
hi SpellCap         ctermfg=215  ctermbg=NONE guifg=NONE    guibg=NONE    guisp=#7fb0df cterm=NONE,underline gui=NONE,undercurl
hi SpellLocal       ctermfg=77   ctermbg=NONE guifg=NONE    guibg=NONE    guisp=#5eb9b7 cterm=NONE,underline gui=NONE,undercurl
hi SpellRare        ctermfg=176  ctermbg=NONE guifg=NONE    guibg=NONE    guisp=#c39dd1 cterm=NONE,underline gui=NONE,undercurl
hi StorageClass     ctermfg=139  ctermbg=NONE guifg=#a88cb3 guibg=NONE    guisp=NONE    cterm=NONE           gui=NONE
hi Structure        ctermfg=139  ctermbg=NONE guifg=#a88cb3 guibg=NONE    guisp=NONE    cterm=NONE           gui=NONE
hi Type             ctermfg=139  ctermbg=NONE guifg=#a88cb3 guibg=NONE    guisp=NONE    cterm=NONE           gui=NONE
hi Typedef          ctermfg=139  ctermbg=NONE guifg=#a88cb3 guibg=NONE    guisp=NONE    cterm=NONE           gui=NONE
hi TooLong          ctermfg=139  ctermbg=236  guifg=#a88cb3 guibg=#2c2d30 guisp=NONE    cterm=NONE,reverse   gui=NONE,reverse
hi WarningMsg       ctermfg=131  ctermbg=NONE guifg=#a88cb3 guibg=#2c2d30 guisp=NONE    cterm=NONE           gui=NONE
hi Function         ctermfg=138  ctermbg=NONE guifg=#be868c guibg=NONE    guisp=NONE    cterm=NONE           gui=NONE
hi Identifier       ctermfg=138  ctermbg=NONE guifg=#be868c guibg=NONE    guisp=NONE    cterm=NONE           gui=NONE
hi DiffDelete       ctermfg=138  ctermbg=236  guifg=#be868c guibg=#2c2d30 guisp=NONE    cterm=NONE,reverse   gui=NONE,reverse
hi DiffRemoved      ctermfg=138  ctermbg=236  guifg=#be868c guibg=#2c2d30 guisp=NONE    cterm=NONE,reverse   gui=NONE,reverse
" hi DiffDelete       ctermfg=236  ctermbg=167  guifg=#be868c guibg=#2c2d30 guisp=NONE    cterm=NONE           gui=NONE
" hi DiffRemoved      ctermfg=236  ctermbg=167  guifg=#be868c guibg=#2c2d30 guisp=NONE    cterm=NONE           gui=NONE
hi Error            ctermfg=131  ctermbg=234  guifg=#be868c guibg=#2c2d30 guisp=NONE    cterm=reverse           gui=NONE
hi ErrorMsg         ctermfg=131  ctermbg=234  guifg=#be868c guibg=#2c2d30 guisp=NONE    cterm=reverse           gui=NONE
hi Debug            ctermfg=137  ctermbg=NONE guifg=#ab916d guibg=NONE    guisp=NONE    cterm=NONE           gui=NONE
hi Delimiter        ctermfg=137  ctermbg=NONE guifg=#ab916d guibg=NONE    guisp=NONE    cterm=NONE           gui=NONE
hi Special          ctermfg=137  ctermbg=NONE guifg=#ab916d guibg=NONE    guisp=NONE    cterm=NONE           gui=NONE
hi SpecialChar      ctermfg=137  ctermbg=NONE guifg=#ab916d guibg=NONE    guisp=NONE    cterm=NONE           gui=NONE
hi SpecialComment   ctermfg=137  ctermbg=NONE guifg=#ab916d guibg=NONE    guisp=NONE    cterm=NONE           gui=NONE
hi SpecialKey       ctermfg=59   ctermbg=237  guifg=#ab916d guibg=NONE    guisp=NONE    cterm=NONE           gui=NONE
hi Tag              ctermfg=137  ctermbg=NONE guifg=#ab916d guibg=NONE    guisp=NONE    cterm=NONE           gui=NONE
hi DiffText         ctermfg=137  ctermbg=236  guifg=#ab916d guibg=#2c2d30 guisp=NONE    cterm=NONE,reverse   gui=NONE,reverse
"hi Search           ctermfg=137  ctermbg=236  guifg=#ab916d guibg=#2c2d30 guisp=NONE    cterm=NONE,reverse   gui=NONE,reverse
hi Conditional      ctermfg=108  ctermbg=NONE guifg=#7f9d77 guibg=NONE    guisp=NONE    cterm=NONE           gui=NONE
hi Exception        ctermfg=108  ctermbg=NONE guifg=#7f9d77 guibg=NONE    guisp=NONE    cterm=NONE           gui=NONE
hi Keyword          ctermfg=108  ctermbg=NONE guifg=#7f9d77 guibg=NONE    guisp=NONE    cterm=NONE           gui=NONE
hi Label            ctermfg=108  ctermbg=NONE guifg=#7f9d77 guibg=NONE    guisp=NONE    cterm=NONE           gui=NONE
hi Operator         ctermfg=108  ctermbg=NONE guifg=#7f9d77 guibg=NONE    guisp=NONE    cterm=NONE           gui=NONE
hi Repeat           ctermfg=108  ctermbg=NONE guifg=#7f9d77 guibg=NONE    guisp=NONE    cterm=NONE           gui=NONE
hi Statement        ctermfg=108  ctermbg=NONE guifg=#7f9d77 guibg=NONE    guisp=NONE    cterm=NONE           gui=NONE
hi DiffAdd          ctermfg=108  ctermbg=236  guifg=#7f9d77 guibg=#2c2d30 guisp=NONE    cterm=NONE,reverse   gui=NONE,reverse
hi DiffAdded        ctermfg=108  ctermbg=236  guifg=#7f9d77 guibg=#2c2d30 guisp=NONE    cterm=NONE,reverse   gui=NONE,reverse
" hi DiffAdd          ctermfg=255  ctermbg=64   guifg=#7f9d77 guibg=#2c2d30 guisp=NONE    cterm=bold           gui=NONE,reverse
" hi DiffAdded        ctermfg=255  ctermbg=64   guifg=#7f9d77 guibg=#2c2d30 guisp=NONE    cterm=bold           gui=NONE,reverse
hi Define           ctermfg=73   ctermbg=NONE guifg=#5da19f guibg=NONE    guisp=NONE    cterm=NONE           gui=NONE
hi Include          ctermfg=73   ctermbg=NONE guifg=#5da19f guibg=NONE    guisp=NONE    cterm=NONE           gui=NONE
hi Macro            ctermfg=73   ctermbg=NONE guifg=#5da19f guibg=NONE    guisp=NONE    cterm=NONE           gui=NONE
hi PreCondit        ctermfg=73   ctermbg=NONE guifg=#5da19f guibg=NONE    guisp=NONE    cterm=NONE           gui=NONE
hi PreProc          ctermfg=73   ctermbg=NONE guifg=#5da19f guibg=NONE    guisp=NONE    cterm=NONE           gui=NONE
hi Todo             ctermfg=73   ctermbg=236  guifg=#5da19f guibg=#2c2d30 guisp=NONE    cterm=NONE,reverse   gui=NONE,reverse
hi Boolean          ctermfg=110  ctermbg=NONE guifg=#759abd guibg=NONE    guisp=NONE    cterm=NONE           gui=NONE
hi Character        ctermfg=110  ctermbg=NONE guifg=#759abd guibg=NONE    guisp=NONE    cterm=NONE           gui=NONE
hi Constant         ctermfg=110  ctermbg=NONE guifg=#759abd guibg=NONE    guisp=NONE    cterm=NONE           gui=NONE
hi Float            ctermfg=110  ctermbg=NONE guifg=#759abd guibg=NONE    guisp=NONE    cterm=NONE           gui=NONE
hi Number           ctermfg=110  ctermbg=NONE guifg=#759abd guibg=NONE    guisp=NONE    cterm=NONE           gui=NONE
hi String           ctermfg=110  ctermbg=NONE guifg=#759abd guibg=NONE    guisp=NONE    cterm=NONE           gui=NONE
"hi Visual           ctermfg=NONE ctermbg=237  guifg=#759abd guibg=#2c2d30 guisp=NONE    cterm=NONE,bold      gui=NONE,reverse
"hi VisualNOS        ctermfg=NONE ctermbg=237  guifg=#8c95a0 guibg=#2c2d30 guisp=NONE    cterm=NONE,bold      gui=NONE,reverse

