local conf = require('telescope.config').values
local finders = require('telescope.finders')
local make_entry = require('telescope.make_entry')
local pickers = require('telescope.pickers')
local builtin = require('telescope.builtin')

return {
  search_dotfiles = function()
    builtin.find_files({
      prompt_title = '< Config Files >',
      cwd = '~/github/dotfiles/'
    })
  end,
  -- instead of git ls-files, use fd for searching a project,
  -- as it respects .gitignore and we can easily exlude extra
  -- types of files that are committed but not of interest.
  find_files_project = function()
    builtin.find_files({
      prompt_title = '< Project Files >',
      find_command = {
        'fd',
        '-t',
        'file',
        '-H', -- include hidden files
        '-E',
        '.yarn' -- exclude .yarn folder (zero-install projects)

      },
      prompt_prefix = '🔍'
    })
  end,
  find_files = function()
    builtin.find_files({
      prompt_title = '< Find Files >',
      find_command = {
        'fd',
        '-t',
        'file',
        '-H', -- include hidden files
        '--no-ignore-vcs' -- don't respect .gitignore
      },
      prompt_prefix = '🔍'
    })
  end,
  -- Grep for the current word under the cursor.
  -- Note that Telescope will escape any special characters so that this
  -- actually does a literal search.
  grep_cword = function()
    local search = vim.fn.expand('<cword>')
    builtin.grep_string({
      prompt_title = 'search: ' .. search,
      prompt_prefix = '🔍',
      search = search
    })
  end,
  -- Prompt to enter a pattern and then grep for it.
  -- This custom approach avoids escaping special characters so that this will
  -- interpret what you enter as a pattern. For now, errors from rg will be
  -- passed to Telescope as well as stdout, causing nil:nil:nil:nil entries
  grep_pattern = function(pattern)
    local opts = {}
    opts.entry_maker = make_entry.gen_from_vimgrep()

    local args = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      pattern
    }

    pickers.new(opts, {
      prompt_title = 'search: ' .. pattern,
      prompt_prefix = '🔍',
      finder = finders.new_oneshot_job(args, opts),
      previewer = conf.grep_previewer(opts),
      sorter = conf.generic_sorter(opts)
    }):find()
  end
}
