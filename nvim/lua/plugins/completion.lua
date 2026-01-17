return {
	'saghen/blink.cmp',
	-- version = '1.*',

	-- build = "cargo build --release",
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = {
			preset = 'default',

			['<C-s>'] = { 'select_and_accept', 'fallback' },
		},

		appearance = {
			nerd_font_variant = 'mono'
		},

		completion = { documentation = { auto_show = false } },

		sources = {
			default = { 'lsp', 'path', 'snippets', 'buffer' },
		},

		fuzzy = { implementation = "lua" }
	},
	opts_extend = { "sources.default" }
}
