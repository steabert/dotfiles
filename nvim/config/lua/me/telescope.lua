return {
    search_dotfiles = function()
        require('telescope.builtin').find_files(
            {prompt_title = '< Config Files >', cwd = '~/github/dotfiles/'})
    end,
    grep_string = function()
        local pattern = vim.fn.expand('<cword>')
        require('telescope.builtin').grep_string(
            {
                prompt_title = 'search: ' .. pattern,
                prompt_prefix = '🔍',
                search = pattern
            })
    end,
    -- instead of git ls-files, use fd for searching a project,
    -- as it respects .gitignore and we can easily exlude extra
    -- types of files that are committed but not of interest.
    find_files_project = function()
        require('telescope.builtin').find_files(
            {
                prompt_title = '< Project Files >',
                find_command = {
                    'fd', '-t', 'file', '-H', -- include hidden files
                    '-E', '.yarn' -- exclude .yarn folder (zero-install projects)

                },
                prompt_prefix = '🔍'
            })
    end,
    find_files = function()
        require('telescope.builtin').find_files(
            {
                prompt_title = '< Find Files >',
                find_command = {
                    'fd', '-t', 'file', '-H', -- include hidden files
                    '--no-ignore-vcs' -- don't respect .gitignore
                },
                prompt_prefix = '🔍'
            })
    end
}
