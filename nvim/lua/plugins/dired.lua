return {
	"nomakwae/dired.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("dired").setup({
			path_separator = "/",
			show_banner = true,
			show_icons = false,
			show_hidden = true,
			show_dot_dirs = true,
			show_colors = true,
			sort_order = "dirs",
			override_cwd = false,

			colors = {
				DiredSymbolicLink = { link = {}, bg = "NONE", fg = "33ccff", gui = "bold" },
				DiredBrokenLink = { link = {}, bg = "2e2e1f", fg = "ff1a1a", gui = "bold" },
				DiredSymbolicLinkTarget = { link = {}, bg = "5bd75b", fg = "000000", gui = "bold" },
				DiredBrokenLinkTarget = { link = {}, bg = "2e2e1f", fg = "ff1a1a", gui = "bold" },
				DiredFileExecutable = { link = {}, bg = "NONE", fg = "5bd75b", gui = "bold" },
				DiredMarkedFile = { link = {}, bg = "NONE", fg = "a8b103", gui = "bold" },
				DiredCopyFile = { link = {}, bg = "NONE", fg = "ff8533", gui = "bold" },
				DiredMoveFile = { link = {}, bg = "NONE", fg = "ff3399", gui = "bold" },
			},

			keybinds = {
				dired_create = "c",
				dired_duplicate = "Y",
				dired_copy = "C",
				dired_copy_range = "C",
				dired_copy_marked = "MC",
				dired_move = "r",
				dired_move_range = "r",
				dired_rename = "R",
				dired_mark = "t",
				dired_mark_range = "t",
				dired_paste = "P",
				dired_delete_marked = "X",
				dired_shell_cmd = "!",
				dired_shell_cmd_marked = "&",
				dired_toggle_hidden = ".",
				dired_toggle_sort_order = ",",
				dired_toggle_colors = "\"",
				dired_toggle_icons = "*",
				dired_toggle_hide_details = "(",
				dired_quit = "q",
			},
		})
	end,
}
