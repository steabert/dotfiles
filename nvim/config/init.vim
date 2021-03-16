" Fish doesn't play all that well with others
set shell=/bin/bash

set nocompatible
set nomodeline " security
let mapleader = "\<Space>"
inoremap <C-l> <Esc>

set ttimeoutlen=10

" Most of these configs are folded to keep it maintainable.
" Use `za` on a folded section to toggle folding (or zR to unfold all).

" Native settings
"""""""""""""""""
" {{{

set title               " use filename to set titlebar
set nobackup            " don't keep a backup file

set noruler             " show the cursor position all the time

set number              " number lines
set relativenumber      " use relative numbers
set scrolloff=4         " leave 4 lines of 'border' at top and bottom

set tabstop=8           " tab key shifts by 8 spaces
set softtabstop=8       " tab key shifts by 8 spaces
set shiftwidth=8        " default indent is 8 spaces
set list
set listchars=tab:➝\ ,

set ignorecase          " make vim case insensitive
set smartcase           " be case sensitive if need be

set textwidth=80

if &diff
        syntax off      " don't color in diff mode
else
        syntax on
endif

" general mappings
noremap <C-j> <Esc>

" deactivate arrow keys
noremap <down> <Nop>
noremap <up> <Nop>
noremap <left> <Nop>
noremap <right> <Nop>
inoremap <left> <Nop>
inoremap <right> <Nop>
inoremap <down> <Nop>
inoremap <up> <Nop>

" }}}

"Plug 'pangloss/vim-javascript'
"Plug 'leafgarland/typescript-vim'
"Plug 'maxmellon/vim-jsx-pretty'
"Plug 'peitalin/vim-jsx-typescript'
"Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

" Theme {{{
packadd! base16

set background=dark
let base16colorspace=256
if filereadable(expand("~/.vimrc_background"))
  source ~/.vimrc_background
else
  colorscheme base16-gruvbox-dark-hard
endif
" }}}

" Fuzzy finder {{{
packadd! fzf
packadd! fzfvim

"let g:fzf_layout = { 'down': '25%' }
" Empty value to disable preview window altogether
let g:fzf_preview_window = []
"nmap <C-o> :Files<CR>
noremap <C-o> :Files<CR>
noremap <C-p> :GFiles<CR>
noremap <C-b> :Buffer<CR>
noremap <C-f> :BLines<CR>
" }}}

" Lightline {{{
packadd! lightline

set laststatus=2
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \   'cocstatus': 'coc#status'
      \ },
      \ }
function! LightlineFilename()
  return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction
" }}}

"""
""" Programming languages
"""

" GraphQL {{{
packadd! graphql
" }}}

" CoC {{{
packadd! coc
" You also need to install the appropriate
" extensions from within nvim with
" :CocInstall coc-go
" :CocInstall coc-rust-analyzer
" :CocInstall coc-sh
" :CocInstall coc-prettier
" :CocInstall coc-eslint
" :CocInstall coc-tsserver
" :CocInstall coc-json

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
set signcolumn=yes
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" jump back and forth
nnoremap <silent> gb <C-o>
nnoremap <silent> gf <C-i>

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" Highlight the symbol and its references when holding the cursor.
"autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Code actions.
nmap <leader>do <Plug>(coc-codeaction)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Use auocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" }}}

" Grep {{{
" from http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
if executable('ag')
	set grepprg=ag\ --nogroup\ --nocolor
endif
if executable('rg')
	set grepprg=rg\ --no-heading\ --vimgrep
	set grepformat=%f:%l:%c:%m
endif
" }}}

" Vim
augroup vim
        autocmd!
        autocmd FileType vim setlocal foldmethod=marker
augroup END

" Git
autocmd FileType gitconfig setlocal noexpandtab
