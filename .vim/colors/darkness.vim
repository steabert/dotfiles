" Vim colorscheme - darkness
" darkspectrum modified for 256 color terminal based on the translations made
" by guicolorscheme and with some tweaks for better vimdiff coloring.

set background=dark
if version > 580
	hi clear
	if exists("syntax_on")
		syntax reset
	endif
endif

set t_Co=256
let g:colors_name = "darkness"

hi Normal         ctermfg=254
hi NonText        ctermfg=239

hi ColorColumn    term=reverse ctermbg=224
hi Comment        ctermfg=244
hi Conceal        ctermfg=7 ctermbg=242
hi Constant       ctermfg=202
hi CursorColumn   term=reverse cterm=NONE
hi CursorLine     ctermbg=233 cterm=NONE
hi CursorLineNr   ctermfg=239 cterm=bold
hi DiffAdd        ctermfg=48  ctermbg=28  cterm=bold
hi DiffChange                 ctermbg=245
hi DiffDelete     ctermfg=256 ctermbg=197 cterm=bold
hi DiffText       ctermfg=123 ctermbg=33 cterm=bold
hi Directory      ctermfg=74
hi Error          term=reverse ctermfg=15 ctermbg=9
hi ErrorMsg       term=standout ctermfg=15 ctermbg=1
hi FoldColumn     cterm=bold ctermfg=254 ctermbg=16
hi FoldeColumn    cterm=bold ctermfg=239 ctermbg=233
hi Folded         cterm=bold ctermfg=239 ctermbg=233
hi Function       ctermfg=139
hi Identifier     ctermfg=74
hi Ignore         ctermfg=239
hi IncSearch      ctermfg=202 ctermbg=254
hi LineNr         ctermfg=239 ctermbg=233
hi MatchParen     ctermfg=254 ctermbg=139
hi ModeMsg        ctermfg=221
hi MoreMsg        ctermfg=221
hi Number         ctermfg=214
hi Pmenu          ctermfg=249 ctermbg=16
hi PmenuSbar      ctermfg=237 ctermbg=237
hi PmenuSel       ctermfg=254 ctermbg=25
hi PmenuThumb     ctermfg=244 ctermbg=244
hi PreProc        cterm=bold ctermfg=254
hi Question       term=standout ctermfg=2
hi Search         ctermfg=254 ctermbg=139
hi SignColumn     term=standout ctermfg=4 ctermbg=248
hi Special        ctermfg=179
hi SpecialKey     ctermfg=112
hi Statement      cterm=bold ctermfg=254
hi StatusLine     ctermfg=254 ctermbg=236
hi StatusLineNC   ctermfg=243 ctermbg=236
hi String         ctermfg=221
hi TabLine        ctermfg=247 ctermbg=233
hi TabLineFill    ctermfg=239 ctermbg=233
hi TabLineSel     cterm=bold ctermfg=254 ctermbg=16
hi Title          ctermfg=202
hi Todo           cterm=bold ctermfg=254 ctermbg=202
hi Type           cterm=bold ctermfg=112
hi Underlined     cterm=underline ctermfg=139
hi VertSplit      ctermfg=236 ctermbg=236
hi Visual         ctermfg=254 ctermbg=25
hi VisualNOS      ctermfg=254 ctermbg=18
hi WarningMsg     ctermfg=202
hi WildMenu       ctermfg=254 ctermbg=25
hi link Boolean        Constant
hi link Character      Constant
hi link Conditional    Statement
hi link Debug          Special
hi link Define         PreProc
hi link Delimiter      Special
hi link Exception      Statement
hi link Float          Number
hi link Include        PreProc
hi link Keyword        Statement
hi link Label          Statement
hi link Macro          PreProc
hi link Operator       Statement
hi link PreCondit      PreProc
hi link Repeat         Statement
hi link SpecialChar    Special
hi link SpecialComment Special
hi link StorageClass   Type
hi link Structure      Type
hi link Tag            Special
hi link Typedef        Type
