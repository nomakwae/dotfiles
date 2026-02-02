-- BOOTSTRAP lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git", "clone", "--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath
	})
end
vim.opt.rtp:prepend(lazypath)

require("core")

require("plugins")

require("local")

-- Set working directory to argument passed
-- If the argument passed is a file, set working directory to its parent
-- If the argument passed is a directory, cd into it
if vim.fn.argc() == 1 then
	local arg = vim.fn.argv()[1]
	local stat = vim.loop.fs_stat(arg)
	if stat then
		local dir = (stat.type == "directory") and arg or vim.fn.fnamemodify(arg, ":h")
		vim.cmd("cd " .. vim.fn.fnameescape(dir))
	end
end
