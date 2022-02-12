require("lualine").setup({
	-- options = {icons_enabled = true, theme = 'ayu_light'},
	options = { icons_enabled = true, theme = "gruvbox" },
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch" },
		lualine_c = {
			{ "filename", full_path = true },
			{ "diagnostics", sources = { "nvim_lsp" } },
		},
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
})

vim.fn.sign_define("LspDiagnosticsSignError", { text = "", texthl = lualine_c_diagnostics_error_normal })
vim.fn.sign_define("LspDiagnosticsSignWarning", { text = "", texthl = lualine_c_diagnostics_warning_normal })
vim.fn.sign_define("LspDiagnosticsSignInformation", { text = "", texthl = lualine_c_diagnostics_info_normal })
vim.fn.sign_define("LspDiagnosticsSignHint", { text = "", texthl = lualine_c_diagnostics_info_normal })
