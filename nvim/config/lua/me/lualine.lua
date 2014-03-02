require('lualine').setup {
  -- options = {icons_enabled = true, theme = 'ayu_light'},
  options = {icons_enabled = true, theme = 'gruvbox'},
  sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch'},
      lualine_c = {
          {'filename', full_path = true},
          {'diagnostics', sources = {'nvim_lsp', 'coc'}}
      },
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
