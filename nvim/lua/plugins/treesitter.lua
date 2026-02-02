return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("nvim-treesitter.configs").setup({
				auto_install = false,
				highlight = {
					enable = true,
					indent = true
				},
			})
		end,
	}
}
