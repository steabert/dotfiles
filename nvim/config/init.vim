set nocompatible
set nomodeline " security

" The leader key will be (mostly) coupled to key sequences that have something
" to do with windows (opening a diagnostic, finding files/text, moving between
" windows).
let mapleader = "\<Space>"

" Most of these configs are folded to keep it readable.  Use `za` on a folded
" section to toggle folding, or use `zM` to fold all or `zR` to unfold all.  By
" default, stuff is folded at start. To disable, use `set nofoldenable`.

" Look and feel {{{
packadd! base16
packadd! devicons

set termguicolors
set background=dark
let base16colorspace=256
if filereadable(expand("~/.vimrc_background"))
  source ~/.vimrc_background
endif
" }}}

" Fuzzy finder {{{
packadd! popup
packadd! plenary
packadd! telescope

" find files
nnoremap <C-f>  <Nop>
nnoremap <C-f>/ :lua require('me.telescope').grep_pattern(vim.fn.input("Grep for > "))<CR>
nnoremap <C-f>* :lua require('me.telescope').grep_cword()<CR>
nnoremap <C-f><C-b> :lua require('telescope.builtin').buffers()<CR>
nnoremap <C-f><C-p> :lua require('me.telescope').find_files_project()<CR>
nnoremap <C-f><C-f> :lua require('me.telescope').find_files()<CR>
nnoremap <C-f><C-y> :lua require('me.telescope').search_dotfiles()<CR>

" browse
nnoremap <C-b> :lua require('telescope.builtin').file_browser()<CR>
nnoremap <C-h> :lua require('telescope.builtin').file_browser({ cwd=vim.fn.expand("%:p:h")})<CR>

" After opening a window to search for a file (or text), just hit enter to open
" the file, or Ctrl-t to open it in a new tab. You can switch tabs with `gt`
" (next tab) or `gT` (previous tab), or `Ngt` where `N` is the tab number
" (starting from 1) to jump immediately to the right tab.  Closing the last
" window in a tab will close the tab itself, so you can just use <leader>x to
" close tabs as well as windows (see window bindings below).

" }}}

" Status bar {{{
packadd! lualine
lua require('me.lualine')

" The status bar can be configured to use icons (but then you need some special
" fonts that have those icons, i.e. nerd fonts). The configuration is in the
" lua file, and we use the defaults there except that we add diagnostics output
" next to the file name (which shows LSP diagnostics).
"
" }}}

" Git {{{
packadd! fugitive
nnoremap <silent>gb :Gblame<CR><C-w>w
nnoremap <silent>gl :0Glog<CR><C-w>w
autocmd FileType gitconfig setlocal noexpandtab
" }}}

" Delimiters {{{
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

" jump to end of line in insert mode (to escape delimiters)
inoremap <C-e> <C-o>A

" }}}

" Comments {{{
packadd! commentary

" Comment stuff out. Use gcc to comment out a line (takes a count), gc to comment
" out the target of a motion (for example, gcap to comment out a paragraph), gc in
" visual mode to comment out the selection, and gc in operator pending mode to
" target a comment. You can also use it as a command, either with a range like
" :7,17Commentary, or as part of a :global invocation like with
" :g/TODO/Commentary. That's it.

" }}}

"""
""" Programming language support
"""

" Intellisense {{{
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
" Setup LSP
set signcolumn=yes
setlocal omnifunc=v:lua.vim.lsp.omnifunc
inoremap <silent> <C-Space> <C-x><C-o>

sign define LspDiagnosticsSignError text= texthl=lualine_c_diagnostics_error_normal
sign define LspDiagnosticsSignWarning text= texthl=lualine_c_diagnostics_warning_normal
sign define LspDiagnosticsSignInformation text= texthl=lualine_c_diagnostics_info_normal
sign define LspDiagnosticsSignHint text= texthl=lualine_c_diagnostics_info_normal

" Diagnostics key bindings
nnoremap <silent>gdj	<cmd>lua vim.lsp.diagnostic.goto_next{ wrap = true }<CR>
nnoremap <silent>gdk	<cmd>lua vim.lsp.diagnostic.goto_prev{ wrap = true }<CR>
nnoremap <silent>gd=	<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
nnoremap <silent>L	<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
" Navigation
nnoremap <silent>K	<cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent><C-]>	<cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent><C-s>	<cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent>gdd	<cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent>gdt	<cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent>gdi	<cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent>gdr	<cmd>lua vim.lsp.buf.references()<CR>:copen<CR>
nnoremap <silent>gdc	<cmd>lua vim.lsp.buf.incoming_calls()<CR>:copen<CR>
nnoremap <silent>gdC	<cmd>lua vim.lsp.buf.outgoing_calls()<CR>:copen<CR>
" Refactoring
nnoremap <silent>grn	<cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent>grf	<cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <silent>gra	<cmd>lua vim.lsp.buf.code_action()<CR>

" }}}

" TreeSitter {{{
packadd! treesitter
lua require('me.treesitter')
" }}}

" Code formatting {{{
packadd! neoformat

nnoremap <leader>s :Neoformat<CR>:w<CR>
set shortmess+=w

" There is some formatting capability in the LSP servers, but that's not
" really what we need all the time, and most often formatting is nice to
" have separate from any diagnostics or analysis tool.
" }}}

" JavaScript/TypeScript {{{
lua require('me.lsp-ts')

autocmd FileType javascript,typescript,javascriptreact,typescriptreact,html
			\ setlocal shiftwidth=2 expandtab softtabstop=2
autocmd FileType javascript,typescript,javascriptreact,typescriptreact,html
			\ setlocal makeprg=yarn\ lint\ --format\ unix

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
lua require('me.lsp-go')
" }}}

" GraphQL {{{
packadd! graphql
autocmd FileType graphql setlocal shiftwidth=8 noexpandtab
" }}}

" Shell {{{
autocmd FileType sh setlocal shiftwidth=2 expandtab
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
augroup SVC_VIM
        autocmd!
        autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" Lua {{{
lua require('me.lsp-lua')
autocmd FileType lua setlocal shiftwidth=2 expandtab
" }}}

"""
""" Customization
"""

" Global {{{

filetype plugin indent on

set title               " use filename to set titlebar
set nobackup            " don't keep a backup file
set noswapfile

set noruler             " show the cursor position all the time

set number              " number lines
set relativenumber      " use relative numbers
set scrolloff=999       " leave some lines of 'border' at top and bottom (999 = always middle cursor)
set scroll=20           " how much to scroll with Ctrl-d/Ctrl-u

set tabstop=8           " tab key shifts by 8 spaces
set shiftwidth=8
set noexpandtab
set list
set listchars=tab:➝\ ,

set ignorecase          " make vim case insensitive
set smartcase           " be case sensitive if need be

set textwidth=80
"set colorcolumn=80	" mark position as column

set hidden
set nohlsearch

" easier escape (avoid timeout)
set ttimeoutlen=10
noremap <C-j> <Esc>
inoremap <C-l> <Esc>

" copy to / paste from clipboard in visual mode
noremap  <leader>y "+y
noremap  <leader>p "+p

" }}}

" window shortcuts {{{
" switch windows
nnoremap <leader><Space> <C-w>w
" keep current window (close all others)
nnoremap <leader>h <C-w><C-o>
" close current window
nnoremap <leader>x <C-w>c
" }}}

" quickfix list {{{
nnoremap <C-j> :cnext<CR>
nnoremap <C-k> :cprev<CR>
nnoremap <leader>j :lnext<CR>
nnoremap <leader>k :lprev<CR>
" }}}

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

" reload init
command Reload :source ~/.config/nvim/init.vim
