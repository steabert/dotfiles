require('lualine').setup{
	sections = {
		lualine_a = {'mode'},
		lualine_b = {'branch'},
		lualine_c = {{'diagnostics', sources = {'nvim_lsp'}}},
		lualine_x = {'encoding', 'fileformat', 'filetype'},
		lualine_y = {'progress'},
		lualine_z = {'location'}
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {'filename'},
		lualine_x = {'location'},
		lualine_y = {},
		lualine_z = {}
	}
}
