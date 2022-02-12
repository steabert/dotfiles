-- Leader key
vim.g.mapleader = " "

-- General options
--
vim.opt.background = "dark"
vim.opt.completeopt = { "menuone", "noinsert", "noselect" } -- Set completeopt to have a better completion experience
vim.opt.foldenable = false -- Do not fold by default when opening files
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldmethod = "expr"
vim.opt.formatoptions:append({ t = false })
vim.opt.hidden = true
vim.opt.hlsearch = false
vim.opt.ignorecase = true -- make vim case insensitive
vim.opt.list = true
vim.opt.listchars = "tab:➝ ,"
vim.opt.number = true -- number lines
vim.opt.relativenumber = true -- use relative numbers
vim.opt.scroll = 16 -- how much to scroll with Ctrl-d/Ctrl-u
-- vim.opt.scrolloff = 999 -- leave some lines of 'border' at top and bottom (999 = always middle cursor)
vim.opt.scrolloff = 5 -- leave some lines of 'border' at top and bottom (999 = always middle cursor)
vim.opt.shortmess:append({ c = true }) -- Avoid showing extra message when using completion
vim.opt.shortmess:append({ w = true })
vim.opt.signcolumn = "yes" -- display signs in a column (e.g. LSP diagnostics)
vim.opt.smartcase = true -- be case sensitive if need be
vim.opt.tabstop = 8
vim.opt.termguicolors = true
vim.opt.title = true -- use filename to set titlebar
vim.opt.ttimeoutlen = 10 -- easier escape (avoid timeout)
vim.opt.undofile = true

-- Most of these configs are folded to keep it readable.  Use `za` on a folded
-- section to toggle folding, or use `zM` to fold all or `zR` to unfold all.  By
-- default, stuff is folded at start. To disable, use `set nofoldenable`.

-- Theming {
vim.cmd("packadd! base16")
vim.cmd("packadd! devicons")
require("me.devicons")

vim.cmd("colorscheme base16-monokai")
-- }

-- Search {
vim.cmd("packadd! popup")
vim.cmd("packadd! plenary")
vim.cmd("packadd! telescope")
vim.cmd("packadd! telescope-file-browser")

-- Telescope
--
local my_telescope = require("me.telescope")
local telescope_builtin = require("telescope.builtin")
-- After opening a window to search for a file (or text), just hit enter to open
-- the file, or Ctrl-t to open it in a new tab. You can switch tabs with `gt`
-- (next tab) or `gT` (previous tab), or `Ngt` where `N` is the tab number
-- (starting from 1) to jump immediately to the right tab.  Closing the last
-- window in a tab will close the tab itself, so you can just use <leader>c to
-- close tabs as well as windows (see window bindings below).

-- Status bar
--
vim.cmd("packadd! lualine")
require("me.lualine")
vim.cmd("packadd! bufferline.nvim")
require("bufferline").setup({})

-- Git {
vim.cmd("autocmd FileType gitconfig setlocal noexpandtab")
vim.cmd("autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 expandtab")
vim.cmd("autocmd FileType javascriptreact setlocal shiftwidth=2 tabstop=2 expandtab")
vim.cmd("autocmd FileType typescript setlocal shiftwidth=2 tabstop=2 expandtab")
vim.cmd("autocmd FileType typescriptreact setlocal shiftwidth=2 tabstop=2 expandtab")

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
local git = require("me.git")

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
-- }

-- LSP
vim.cmd("packadd! lspconfig")
require("me.lsp")

-- TreeSitter
vim.cmd("packadd! treesitter")
vim.cmd("packadd! tree-sitter-just")
require("me.treesitter")

-- Code formatting {
vim.cmd("packadd! formatter.nvim")
require("me.formatter")

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
-- When using shfmt to format shell scripts
-- It will follow the shiftwidth settings for the file
-- (which in our case will come from the defaults or
-- from an .editorconfig)
-- }

-- Grep
vim.opt.grepprg = "rg --no-heading --vim-grep"
vim.opt.grepformat = "%f:%l:%c:%m"

-- Bicep
-- au BufRead,BufNewFile *.bicep set filetype=bicep
-- "lua require('lspconfig').bicep.setup{cmd={"dotnet", "/home/stevenv/.azure/bicep-ls/Bicep.LangServer.dll"}}

-- User commands
--
vim.api.nvim_create_user_command("Init", function()
	-- reload init
	vim.cmd("luafile ~/.config/nvim/init.lua")
end, {})

vim.api.nvim_create_user_command("Edit", function(opts)
	-- edit a new file in the current working directory
	vim.cmd("edit %:h/" .. opts.args)
end, { nargs = 1 })

vim.api.nvim_create_user_command("Rename", function()
	-- you can use vim.fs to get basename/dirname
	local oldname = vim.api.nvim_buf_get_name(0)
	vim.ui.input({ prompt = "new name: ", default = oldname, completion = "file" }, function(newname)
		if newname then
			vim.cmd("redraw") -- clear input
			os.rename(oldname, newname)
			vim.api.nvim_buf_set_name(0, newname)
		end
	end)
end, {})

-- Auto commands
--

vim.api.nvim_create_autocmd("TermOpen", { pattern = "*", command = "startinsert" })

-- Keybindings
--

local set_keymap_options = { noremap = true, silent = true }

-- escape
vim.api.nvim_set_keymap("", "<C-j>", "<Esc>", set_keymap_options)
vim.api.nvim_set_keymap("i", "<C-l>", "<Esc>", set_keymap_options)

-- copy to / paste from clipboard in visual mode
vim.api.nvim_set_keymap("", "<Leader>y", [["+y]], set_keymap_options)
vim.api.nvim_set_keymap("", "<Leader>p", [["+p]], set_keymap_options)

-- switch windows
vim.api.nvim_set_keymap("n", "<Leader><Space>", "<C-w>w", set_keymap_options)
-- keep current window (close all others)
vim.api.nvim_set_keymap("n", "<Leader>e", "<C-w><C-o>", set_keymap_options)
-- close current buffer
vim.api.nvim_set_keymap("n", "<Leader>x", ":bd<CR>", set_keymap_options)

-- quickfix list navigation
vim.api.nvim_set_keymap("n", "<C-j>", ":cnext<CR>", set_keymap_options)
vim.api.nvim_set_keymap("n", "<C-k>", ":cprev<CR>", set_keymap_options)

-- file buffer navigation
vim.api.nvim_set_keymap("n", "<Right>", ":bnext<CR>", set_keymap_options)
vim.api.nvim_set_keymap("n", "<Left>", ":bprev<CR>", set_keymap_options)

-- exit and close terminal
vim.api.nvim_set_keymap("t", "<C-c>", "<C-\\><C-n>:bd!<CR>", set_keymap_options)

-- formatting
vim.api.nvim_set_keymap("n", "=", ":FormatWrite<CR>", set_keymap_options)

-- lua function bindings
local normal_mode = {
	["L"] = function()
		vim.diagnostic.open_float()
	end,
	-- ["<Leader>="] = function()
	-- 	vim.lsp.buf.format({
	-- 		-- filter = function(client)
	-- 		-- 	-- apply whatever logic you want (in this example, we'll only use null-ls)
	-- 		-- 	return client.name == "null-ls"
	-- 		-- end,
	-- 	})
	-- 	vim.cmd("write!")
	-- end,
	["<Leader>/"] = function()
		my_telescope.grep_pattern(vim.fn.input("Grep for > "))
	end,
	["<Leader>*"] = function()
		my_telescope.grep_cword()
	end,
	["<Leader>."] = function()
		my_telescope.browse_current_dir()
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
		my_telescope.find_project_files()
	end,
	["<Leader>F"] = function()
		my_telescope.find_all_files()
	end,
	["<Leader>k"] = function()
		vim.lsp.buf.hover()
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
	["gb"] = function()
		git.git_blame()
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
	["gl"] = function()
		git.git_log()
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

for binding, callback in pairs(normal_mode) do
	vim.api.nvim_set_keymap("n", binding, "", { noremap = true, silent = true, callback = callback })
end

local visual_mode = {
	["="] = function()
		vim.lsp.buf.range_formatting()
	end,
}

for binding, callback in pairs(visual_mode) do
	vim.api.nvim_set_keymap("v", binding, "", { noremap = true, silent = true, callback = callback })
end

local terminal_mode = {
	["<C-b>"] = function()
		telescope_builtin.buffers()
	end,
}

for binding, callback in pairs(terminal_mode) do
	vim.api.nvim_set_keymap("t", binding, "", { noremap = true, silent = true, callback = callback })
end
