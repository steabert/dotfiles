" Fish doesn't play all that well with others
set shell=/bin/bash

set nocompatible
set nomodeline " security

let mapleader = "\<Space>"

" Most of these configs are folded to keep it maintainable.
" Use `za` on a folded section to toggle folding,
" or use `zM` to fold all or `zR` to unfold all.
" By default, stuff is folded at start. To disable, use `set nofoldenable`.

" Look and feel {{{
packadd! base16

set termguicolors
set background=dark
let base16colorspace=256
if filereadable(expand("~/.vimrc_background"))
  source ~/.vimrc_background
else
  colorscheme base16-gruvbox-dark-hard
endif
if &diff
        syntax off      " don't color in diff mode
else
        syntax on
endif
" }}}

" Fuzzy finder {{{
packadd! fzf
packadd! fzfvim
nnoremap <leader>o :GFiles<CR>
nnoremap <leader>O :Files<CR>
nnoremap <leader>l :Buffer<CR>
nnoremap <leader>f :BLines<CR>
nnoremap <leader>F :Ag<CR>
" }}}

" Status bar {{{
packadd! lualine
lua require('lualine-init')
" }}}

" Git {{{
packadd! fugitive
nnoremap <expr> <leader>gb &filetype ==# 'fugitiveblame' ? ":quit\r" : ":Gblame\r"
autocmd FileType gitconfig setlocal noexpandtab
" }}}

" Surround {{{
packadd! surround
" }}}

"""
""" Programming language support
"""

" Intellisense (LSP) {{{
packadd! completion
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
set completeopt=menuone,noinsert,noselect
packadd! lspconfig
lua require('lsp-init')
" Setup LSP
set signcolumn=yes
setlocal omnifunc=v:lua.vim.lsp.omnifunc
inoremap <silent> <c-space> <s-x><s-o>
" Diagnostics
nnoremap <leader>d]     <cmd>lua vim.lsp.diagnostic.goto_next{ wrap = true }<CR>
nnoremap <leader>d[     <cmd>lua vim.lsp.diagnostic.goto_prev{ wrap = true }<CR>
nnoremap <leader>d=     <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
nnoremap <leader>dl     <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
" Navigation
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gt    <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>:copen<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
" Refactoring
nnoremap <leader>rn <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <leader>s <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <leader>do <cmd>lua vim.lsp.buf.code_action()<CR>
" }}}

" JavaScript/TypeScript {{{
packadd! javascript
packadd! jsxpretty
packadd! typescript
packadd! jsxtypescript
packadd! styledcomponents
autocmd FileType javascript,typescript,javascriptreact,typescriptreact
			\ setlocal shiftwidth=2 expandtab softtabstop=2
" when working with yarn2, jumping to definitions will open a zip file
" with a path similar to: .yarn/cache/@package.zip/node_modules/.../file.js
" which can be opened by neovim if the string is massaged a little bit.
function! OpenZippedFile(f)
  " get number of new (empty) buffer
  let l:b = bufnr('%')
  " construct full path
  let l:f = substitute(a:f, '.zip/', '.zip::', '')
  let l:f = substitute(l:f, '^', 'zipfile:', '')

  " swap back to original buffer
  b #
  " delete new one
  exe 'bd! ' . l:b
  " open buffer with correct path
  sil exe 'e ' . l:f
  " read in zip data
  call zip#Read(l:f, 1)
endfunction

au BufReadCmd *.yarn/cache/*.zip/* call OpenZippedFile(expand('<afile>'))
" }}}

" GraphQL {{{
packadd! graphql
autocmd FileType graphql setlocal shiftwidth=8 noexpandtab
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

" Vim {{{
augroup vim
        autocmd!
        autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

"""
""" Customization
"""

filetype plugin indent on

set title               " use filename to set titlebar
set nobackup            " don't keep a backup file
set noswapfile

set noruler             " show the cursor position all the time

set number              " number lines
set relativenumber      " use relative numbers
set scrolloff=8         " leave some lines of 'border' at top and bottom

set tabstop=8           " tab key shifts by 8 spaces
set shiftwidth=8
set noexpandtab
set list
set listchars=tab:➝\ ,

set ignorecase          " make vim case insensitive
set smartcase           " be case sensitive if need be

set textwidth=80
set colorcolumn=80

set hidden
set nohlsearch

" easier escape (avoid timeout)
set ttimeoutlen=10
noremap <c-j> <Esc>
inoremap <c-l> <Esc>

" Deactivate arrow keys {{{
noremap  <down>  <Nop>
noremap  <up>    <Nop>
noremap  <left>  <Nop>
noremap  <right> <Nop>
inoremap <left>  <Nop>
inoremap <right> <Nop>
inoremap <down>  <Nop>
inoremap <up>    <Nop>
" }}}

" copy to / paste from clipboard in visual mode
noremap  <leader>y "+y
noremap  <leader>p "+p

" open a new line without any comments
nnoremap <leader>n o<ESC>0c$

" jump back and forth
nnoremap <silent> gb <c-o>
nnoremap <silent> gf <c-i>

" window shortcuts
" switch windows
nnoremap <leader><space> <c-w>w
" keep current window (close all others)
nnoremap <leader>k <c-w><c-o>
" close current window
nnoremap <leader>x <c-w>c
