return {
	search_dotfiles = function()
		require('telescope.builtin').find_files({
			prompt_title = '< DotFiles >',
			cwd = '~/github/dotfiles/',
		})
	end
}
