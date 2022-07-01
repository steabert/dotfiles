return {
	git_blame = function()
		local ft = vim.fn.expand("%:h:t") -- get the current file extension
		if ft == "" then -- if we are in a scratch buffer or unknown filetype
			return
		end
		if ft == "bin" then -- if we are in nvim's terminal window
			return
		end
		-- vim.api.nvim_buf_clear_namespace(0, 2, 0, -1) -- clear out virtual text from namespace 2 (the namespace we will set later)
		local currFile = vim.fn.expand("%")
		local line = vim.api.nvim_win_get_cursor(0)
		local blame_cmd = string.format("git -P blame -c -L %d,%d %s", line[1], line[1], currFile)
		local blame_text = vim.split(vim.fn.system(blame_cmd), "\n")[1]
		local blame_hash = vim.split(blame_text, "%s")[1]
		local text
		if blame_hash == "00000000" then
			text = "Not Committed Yet"
		else
			local show_cmd = string.format("git show %s ", blame_hash) .. "--format='%h | %an - %ar | %s'"
			text = vim.split(vim.fn.system(show_cmd), "\n")[1]
			if text:find("fatal") then -- if the call to git show fails
				text = "failed to show commit " .. blame_hash
			end
		end
		vim.cmd("term git show " .. blame_hash)
		-- set virtual text for namespace 2 with the content from git and assign it to the higlight group 'GitLens'
		-- vim.api.nvim_buf_set_virtual_text(0, 2, line[1] - 1, { { '-- ' .. text, "GitLens" } }, {})
		-- print(text)
	end,
	-- important for clearing out the text when our cursor moves
	-- clearBlameVirtText = function()
	-- 	vim.api.nvim_buf_clear_namespace(0, 2, 0, -1)
	-- end,
	git_log = function()
		local ft = vim.fn.expand("%:h:t") -- get the current file extension
		if ft == "" then -- if we are in a scratch buffer or unknown filetype
			return
		end
		if ft == "bin" then -- if we are in nvim's terminal window
			return
		end
		local currFile = vim.fn.expand("%")
		vim.cmd("term git log --pretty=medium -p -- " .. currFile)
	end,
}
