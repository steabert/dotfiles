-- The leader key will be (mostly) coupled to key sequences that have something
-- to do with windows (opening a diagnostic, finding files/text, moving between
-- windows).
-- let mapleader = "\<Space>"
vim.g.mapleader = " "

-- Most of these configs are folded to keep it readable.  Use `za` on a folded
-- section to toggle folding, or use `zM` to fold all or `zR` to unfold all.  By
-- default, stuff is folded at start. To disable, use `set nofoldenable`.

-- Theming {
vim.cmd("packadd! base16")
vim.cmd("packadd! devicons")
require("me.devicons")

vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.cmd("colorscheme base16-monokai")
-- }

-- Search {
vim.cmd("packadd! popup")
vim.cmd("packadd! plenary")
vim.cmd("packadd! telescope")
vim.cmd("packadd! telescope-file-browser")

local my_telescope = require("me.telescope")
local telescope_builtin = require("telescope.builtin")
-- After opening a window to search for a file (or text), just hit enter to open
-- the file, or Ctrl-t to open it in a new tab. You can switch tabs with `gt`
-- (next tab) or `gT` (previous tab), or `Ngt` where `N` is the tab number
-- (starting from 1) to jump immediately to the right tab.  Closing the last
-- window in a tab will close the tab itself, so you can just use <leader>c to
-- close tabs as well as windows (see window bindings below).

-- }

-- Status bar {
vim.cmd("packadd! lualine")
require("me.lualine")
-- The status bar can be configured to use icons (but then you need some special
-- fonts that have those icons, i.e. nerd fonts). The configuration is in the
-- lua file, and we use the defaults there except that we add diagnostics output
-- next to the file name (which shows LSP diagnostics).
-- }

-- Git {
vim.cmd("autocmd FileType gitconfig setlocal noexpandtab")

-- " Read commit diff into quickfix list
-- " command -nargs=1 Gdiff cexpr system('git diff <args> HEAD -U0 | ~/.config/nvim/sbin/diff2qf')
-- function! MyGdiff(...)
--     let src = get(a:, 1, 'HEAD~1')
--
--     copen
-- endfunction
-- command -nargs=1 Gdiff call MyGdiff(<q-args>)
-- vim.api.nvim_create_user_command("Gdiff", function(opts) end, { nargs = 1 })

-- " mergetool with diff view can be used (see mergetool.vim)
-- " make sure LOCAL is on the left, REMOTE is on the right.
-- nnoremap <leader>dh :diffget LO<CR>
-- nnoremap <leader>dl :diffget RE<CR>
-- nnoremap <leader>db :diffget BA<CR>

-- " Git blame virtual text
local my_blame = require("me.blame")
vim.api.nvim_set_keymap("n", "<Leader>B", "", {
	noremap = true,
	silent = true,
	callback = function()
		my_blame.gitBlame()
	end,
})

-- " Delimiters {
vim.cmd("packadd! surround")

-- " To change one type of quotes to another, use `csXY`
-- " with X and Y the characters representing from => to
-- " while positioned on the word.
-- "
-- " "hello" cs"' => 'hello'
-- " 'hello' cs'( => ( hello )
-- " 'hello' cs') => (hello)
-- " {hello} cs}{ => { hello }
-- "
-- " To add or remove quotes around a word, use either
-- " `ysiwX` (add), or `dsX` (delete):
-- "
-- " (hello) ds(   => hello
-- " (hello) ds)   => hello
-- " hello   ysiw{ => { hello }
-- " hello   ysiw} => { hello }
-- "
-- " With parentheses, using the open version keeps a space,
-- " using the closed version adds no space when adding
-- " (no difference when removing).

-- " jump to end of line in insert mode (to escape delimiters)
-- inoremap <C-e> <C-o>A

-- " }

-- " Comments {
vim.cmd("packadd! commentary")

-- " Comment stuff out. Use gcc to comment out a line (takes a count), gc to comment
-- " out the target of a motion (for example, gcap to comment out a paragraph), gc in
-- " visual mode to comment out the selection, and gc in operator pending mode to
-- " target a comment. You can also use it as a command, either with a range like
-- " :7,17Commentary, or as part of a :global invocation like with
-- " :g/TODO/Commentary. That's it.

-- " }

-- """
-- """ Programming language support
-- """

-- " Completion {
vim.cmd("packadd! nvim-cmp")
vim.cmd("packadd! cmp-nvim-lsp")
vim.cmd("packadd! cmp-buffer")
vim.cmd("packadd! cmp-cmdline")
vim.cmd("packadd! cmp-path")
vim.cmd("packadd! lspkind-nvim")
require("me.cmp")
-- Set completeopt to have a better completion experience
vim.opt.completeopt = { "menuone", "noinsert", "noselect" }
-- Avoid showing extra message when using completion
vim.opt.shortmess:append({ c = true })
-- }

-- " LSP {
vim.cmd("packadd! lspconfig")
require("me.lsp")

-- LSP relies on a bunch of language servers, a lot of which are
-- related to TS for us, so install language servers with yarn global:
-- graphql-lsp
-- yaml-language-server
-- vscode-json-language-server
-- vscode-html-language-server
-- vscode-eslint-language-server
-- vscode-css-language-server
-- typescript-language-server
-- tsserver

vim.opt.signcolumn = "yes"
vim.fn.sign_define("LspDiagnosticsSignError", { text = "", texthl = lualine_c_diagnostics_error_normal })
vim.fn.sign_define("LspDiagnosticsSignWarning", { text = "", texthl = lualine_c_diagnostics_warning_normal })
vim.fn.sign_define("LspDiagnosticsSignInformation", { text = "", texthl = lualine_c_diagnostics_info_normal })
vim.fn.sign_define("LspDiagnosticsSignHint", { text = "", texthl = lualine_c_diagnostics_info_normal })

-- " }

-- " TreeSitter {
vim.cmd("packadd! treesitter")
require("me.treesitter")
-- " }

-- Code formatting {
vim.cmd("packadd! neoformat")

vim.api.nvim_set_keymap("n", "=", [[<Cmd>Neoformat<CR>:w<CR>]], { noremap = true, silent = true })
vim.opt.shortmess:append({ w = true })

-- There is some formatting capability in the LSP servers, but that's not
-- really what we need all the time, and most often formatting is nice to
-- have separate from any diagnostics or analysis tool.
-- }

-- JavaScript/TypeScript {
-- For now, use CoC with JS/TS, eslint, and styled components, by running
-- :CocInstall coc-tsserver coc-eslint coc-styled-components coc-json
-- The use of LSP with tsserver works better for navigating code, wo we
-- use that instead.
vim.cmd("packadd! styledcomponents")

-- vim.cmd('autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 expandtab')
-- vim.cmd('autocmd FileType javascriptreact setlocal shiftwidth=2 tabstop=2 expandtab')
-- vim.cmd('autocmd FileType typescript setlocal shiftwidth=2 tabstop=2 expandtab')
-- vim.cmd('autocmd FileType typescriptreact setlocal shiftwidth=2 tabstop=2 expandtab')

-- " When working with yarn2, jumping to definitions will open a zip file
-- " with a path similar to: `.yarn/cache/@package.zip/node_modules/.../file.js`,
-- " which can be opened by neovim if the string is massaged a little bit.
-- function! OpenZippedFile(f)
--   " get number of new (empty) buffer
--   let l:b = bufnr('%')
--   " construct full path
--   let l:f = substitute(a:f, '.zip/', '.zip::', '')
--   let l:f = substitute(l:f, '.yarn/.*/cache/', '.yarn/cache/', '')
--   let l:f = substitute(l:f, '^', 'zipfile:', '')

--   " swap back to original buffer
--   b #
--   " delete new one
--   exe 'bd! ' . l:b
--   " open buffer with correct path
--   sil exe 'e ' . l:f
--   " read in zip data
--   call zip#Read(l:f, 1)
-- endfunction

-- au BufReadCmd *.yarn/*cache/*.zip/* call OpenZippedFile(expand('<afile>'))
-- " }

-- Shell {
-- Neoformat will use shfmt to format shell scripts
-- It will follow the shiftwidth settings for the file
-- (which in our case will come from the defaults or
-- from an .editorconfig)
-- }

-- Grep
vim.opt.grepprg = "rg --no-heading --vim-grep"
vim.opt.grepformat = "%f:%l:%c:%m"

-- Vim
-- augroup SVC_VIM
--         autocmd!
--         autocmd FileType vim setlocal foldmethod=marker
-- augroup END

-- Bicep
-- au BufRead,BufNewFile *.bicep set filetype=bicep
-- "lua require('lspconfig').bicep.setup{cmd={"dotnet", "/home/stevenv/.azure/bicep-ls/Bicep.LangServer.dll"}}

-- """
-- """ Customization
-- """

-- filetype plugin indent on

vim.opt.title = true -- use filename to set titlebar
vim.opt.number = true -- number lines
vim.opt.relativenumber = true -- use relative numbers
vim.opt.scrolloff = 999 -- leave some lines of 'border' at top and bottom (999 = always middle cursor)
vim.opt.scroll = 20 -- how much to scroll with Ctrl-d/Ctrl-u
vim.opt.list = true
vim.opt.listchars = "tab:➝ ,"
vim.opt.tabstop = 8
vim.opt.ignorecase = true -- make vim case insensitive
vim.opt.smartcase = true -- be case sensitive if need be
vim.opt.formatoptions:append({ t = false })
vim.opt.hidden = true
vim.opt.ttimeoutlen = 10 -- easier escape (avoid timeout)

-- Commands
--
vim.api.nvim_create_user_command("Reload", function()
	-- reload init
	vim.cmd("source ~/.config/nvim/init.lua")
end, {})

vim.api.nvim_create_user_command("Edit", function(opts)
	-- edit a new file in the current working directory
	vim.cmd("edit %:h/" .. opts.args)
end, { nargs = 1 })

-- Keybindings
--
vim.api.nvim_set_keymap("", "<C-j>", "<Esc>", { noremap = true })
vim.api.nvim_set_keymap("i", "<C-l>", "<Esc>", { noremap = true })

-- copy to / paste from clipboard in visual mode
vim.api.nvim_set_keymap("", "<Leader>y", [["+y]], { noremap = true })
vim.api.nvim_set_keymap("", "<Leader>p", [["+p]], { noremap = true })

-- map indenting/unindenting to tab/shift-tab
vim.api.nvim_set_keymap("", "<>>", "<C-t>", { noremap = true })
vim.api.nvim_set_keymap("", "<<>", "<C-d>", { noremap = true })

-- switch windows
vim.api.nvim_set_keymap("n", "<Leader><Space>", "<C-w>w", { noremap = true })
-- keep current window (close all others)
vim.api.nvim_set_keymap("n", "<Leader>e", "<C-w><C-o>", { noremap = true })
-- close current window
vim.api.nvim_set_keymap("n", "<Leader>x", "<C-w>c", { noremap = true })

-- quickfix list {
vim.api.nvim_set_keymap("n", "<C-j>", ":cnext<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-k>", ":cprev<CR>", { noremap = true })

-- lua function bindings
local normal_silent = {
	["L"] = function()
		vim.diagnostic.open_float()
	end,
	["K"] = function()
		vim.lsp.buf.hover()
	end,
	["<Leader>/"] = function()
		my_telescope.grep_pattern(vim.fn.input("Grep for > "))
	end,
	["<Leader>*"] = function()
		my_telescope.grep_cword()
	end,
	["<Leader>a"] = function()
		vim.lsp.buf.code_action()
	end,
	["<Leader>b"] = function()
		telescope_builtin.buffers()
	end,
	["<Leader>c"] = function()
		my_telescope.search_dotfiles()
	end,
	["<Leader>f"] = function()
		my_telescope.find_files_project()
	end,
	["<Leader>F"] = function()
		require("telescope").extensions.file_browser.file_browser({ path = vim.fn.expand("%:p:h") })
	end,
	["<Leader>n"] = function()
		my_telescope.search_kb()
	end,
	["<Leader>w"] = function()
		my_telescope.git_worktree()
	end,
	["<Leader>W"] = function()
		my_telescope.git_trunk()
	end,
	["<Leader>q"] = function()
		my_telescope.git_show_qf()
	end,
	["<Leader>r"] = function()
		vim.lsp.buf.rename()
	end,
	["<Leader>s"] = function()
		telescope_builtin.lsp_document_symbols()
	end,
	["<Leader>S"] = function()
		telescope_builtin.lsp_workspace_symbols()
	end,
	["]d"] = function()
		vim.diagnostic.goto_next({ wrap = true })
	end,
	["[d"] = function()
		vim.diagnostic.goto_prev({ wrap = true })
	end,
	["]l"] = function()
		telescope_builtin.diagnostics({ bufnr = 0 })
	end,
	["]L"] = function()
		telescope_builtin.diagnostics()
	end,
	["]q"] = function()
		vim.diagnostic.setqflist()
	end,
	["gd"] = function()
		telescope_builtin.lsp_definitions()
	end,
	["<C-s>"] = function()
		vim.lsp.buf.signature_help()
	end,
	["gD"] = function()
		vim.lsp.buf.declaration()
	end,
	["gy"] = function()
		telescope_builtin.lsp_type_definitions()
	end,
	["gi"] = function()
		telescope_builtin.lsp_implementations()
	end,
	["gr"] = function()
		telescope_builtin.lsp_references()
	end,
}

for binding, callback in pairs(normal_silent) do
	vim.api.nvim_set_keymap("n", binding, "", { noremap = true, silent = true, callback = callback })
end
