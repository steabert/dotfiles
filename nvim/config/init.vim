" Fish doesn't play all that well with others
set shell=/bin/bash

set nocompatible
set nomodeline " security

" The leader key will be (mostly) coupled to key sequences that have something
" to do with windows (opening a diagnostic, finding files/text with fzf, moving
" between windows).
let mapleader = "\<Space>"

" Most of these configs are folded to keep it readable.  Use `za` on a folded
" section to toggle folding, or use `zM` to fold all or `zR` to unfold all.  By
" default, stuff is folded at start. To disable, use `set nofoldenable`.

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
nnoremap <leader>F :Rg<CR>

" After opening a window to search for a file (or text), just hit enter to open
" the file, or Ctrl-t to open it in a new tab. You can switch tabs with `gt`
" (next tab) or `gT` (previous tab), or `Ngt` where `N` is the tab number
" (starting from 1) to jump immediately to the right tab.
" Closing the last window in a tab will close the tab itself, so you can just
" use <leader>x to close tabs as well as windows (see window bindings below).
"
" }}}

" Status bar {{{
packadd! lualine
lua require('lualine-init')

" The status bar can be configured to use icons (but then you need some special
" fonts that have those icons, i.e. nerd fonts). The configuration is in the
" lua file, and we use the defaults there except that we add diagnostics output
" next to the file name (which shows LSP diagnostics).
"
" }}}

" Git {{{
packadd! fugitive
nnoremap <expr> <leader>gb &filetype ==# 'fugitiveblame' ? ":quit\r" : ":Gblame\r"
autocmd FileType gitconfig setlocal noexpandtab
" }}}

" Surround {{{
packadd! surround

" To change one type of quotes to another, use `csXY`
" with X and Y the characters representing from => to
" while positioned on the word.
"
" "hello" cs"' => 'hello'
" 'hello' cs'( => ( hello )
" 'hello' cs') => (hello)
" {hello} cs}{ => { hello }
"
" To add or remove quotes around a word, use either
" `ysiwX` (add), or `dsX` (delete):
"
" (hello) ds(   => hello
" (hello) ds)   => hello
" hello   ysiw{ => { hello }
" hello   ysiw} => { hello }
"
" With parentheses, using the open version keeps a space,
" using the closed version adds no space when adding
" (no difference when removing).
"
" }}}

"""
""" Programming language support
"""

" Intellisense (LSP) {{{
packadd! completion
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
" Avoid showing message extra message when using completion
set shortmess+=c

packadd! lspconfig
lua require('lsp-init')
" Setup LSP
set signcolumn=yes
setlocal omnifunc=v:lua.vim.lsp.omnifunc
inoremap <silent> <c-space> <c-x><c-o>
" Diagnostics
nnoremap <leader>d]     <cmd>lua vim.lsp.diagnostic.goto_next{ wrap = true }<CR>
nnoremap <leader>d[     <cmd>lua vim.lsp.diagnostic.goto_prev{ wrap = true }<CR>
nnoremap <leader>d=     <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
nnoremap <leader>dl     <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
" Navigation
nnoremap <silent>K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent><c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent><c-s> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent>gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent>gi    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent>gD    <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent>gr    <cmd>lua vim.lsp.buf.references()<CR>:copen<CR>
nnoremap <silent>g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent>gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
" Refactoring
nnoremap <leader>rn     <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <leader>s      <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <leader>do     <cmd>lua vim.lsp.buf.code_action()<CR>
" }}}

" JavaScript/TypeScript {{{
packadd! javascript
packadd! jsxpretty
packadd! typescript
packadd! jsxtypescript
packadd! styledcomponents
autocmd FileType javascript,typescript,javascriptreact,typescriptreact
			\ setlocal shiftwidth=2 expandtab softtabstop=2

" When working with yarn2, jumping to definitions will open a zip file
" with a path similar to: `.yarn/cache/@package.zip/node_modules/.../file.js`,
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

" Go {{{
packadd! vimgo
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
noremap  <silent>gc "+y
noremap  <silent>gp "+p

" open a new line without any comments
nnoremap <leader>n o<ESC>0c$

" jump back and forth
nnoremap <silent>gb <c-o>
nnoremap <silent>gf <c-i>

" window shortcuts
" switch windows
nnoremap <leader><space> <c-w>w
" keep current window (close all others)
nnoremap <leader>k <c-w><c-o>
" close current window
nnoremap <leader>x <c-w>c
