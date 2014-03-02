" Configuration file for vim

" load local plugins
call pathogen#infect()

"General settings
"================

" basic configuration {{{
set title               " use filename to set titlebar
set nocompatible        " don't try to be comaptible with vi
set nobackup            " don't keep a backup file
filetype plugin on      " load filetype specific plugins

set noruler             " show the cursor position all the time
set laststatus=2        " needed to display status line

set number              " number lines
set relativenumber      " use relative numbers
set scrolloff=2         " leave 4 lines of 'border'

set tabstop=8           " tab key shifts by 4 spaces
set softtabstop=8       " tab key shifts by 4 spaces
set shiftwidth=8        " default indent is 4 spaces
set expandtab           " convert tabs to spaces

set ignorecase          " make vim case insensitive
set smartcase           " be case sensitive if need be

set autoindent          " new line gets same indentation
filetype indent on      " load filetype specific indentation

set ttimeoutlen=10      " set timeout for keycodes
" }}}

" format options {{{
augroup formatting
        autocmd!
        autocmd FileType * setlocal formatoptions-=o
augroup END
" }}}

" syntax & coloring {{{
syntax on
if &diff | syntax off | endif
colorscheme darkness
set cursorline
" }}}

" cursor block/underscore {{{
if exists('$TMUX')
        let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>[3 q\<Esc>\\"
        let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>[2 q\<Esc>\\"
else
        let &t_SI = "\<Esc>[3 q"
        let &t_EI = "\<Esc>[2 q"
endif
" }}}

" tagging {{{
set tags=./tags;
let Tlist_Compact_Format = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select = 1
nnoremap <C-l> :TlistToggle<CR>
" }}}

"Mappings
"========

" quickly edit/source ~/.vimrc {{{
:nnoremap <leader>ev :split $MYVIMRC<CR>
:nnoremap <leader>sv :source $MYVIMRC<CR>
" }}}

" general mappings {{{
inoremap <C-n> <Esc>
" }}}

" deactivate arrow keys {{{
noremap <down> <Nop>
noremap <up> <Nop>
noremap <left> <Nop>
noremap <right> <Nop>
inoremap <left> <Nop>
inoremap <right> <Nop>
inoremap <down> <Nop>
inoremap <up> <Nop>
" }}}

" insert two delimiters {{{
inoremap ' ''<ESC>i
inoremap " ""<ESC>i
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap { {}<ESC>i
" }}}

"Type-specific settings
"======================

" Vim {{{
augroup vim
        autocmd!
        autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" Git {{{
autocmd FileType gitconfig setlocal noexpandtab
" }}}

" Fortran {{{
let fortran_do_enddo=1
let fortran_indent_less=1
" }}}

" LaTeX {{{
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"
" }}}

" Molcas {{{
function! MolcasHelp()
        normal! ma
        normal! viwy`a
        let l:keyword = @"
        normal! 0yl`a
        if @" == ">"
                let l:args = "emil " . l:keyword
        else
                normal! ? *&f&lyw`a
                if @" == l:keyword
                        let l:args = l:keyword
                else
                        let l:args = @" . " " . l:keyword
                endif
        endif
        execute "split | enew | setlocal buftype=nowrite | r !molcas help -b " . l:args
endfunction

augroup molcas_setup
        autocmd!
        autocmd BufNewFile,BufRead *.input setlocal syntax=emil
        autocmd BufNewFile,BufRead *.input noremap <buffer> K :call MolcasHelp()<CR>
        autocmd BufNewFile,BufRead *.inc,*.fh setlocal filetype=fortran
        autocmd BufNewFile,BufRead *.cfg,*.comp setlocal filetype=sh
augroup END
" }}}
