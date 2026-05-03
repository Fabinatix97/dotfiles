return {
	"folke/which-key.nvim",
	event = "VimEnter",
	opts = {
		delay = 1000,
		icons = { mappings = vim.g.have_nerd_font },

		-- Document existing key chains
		spec = {
			{ "<leader>s", group = "[S]earch", mode = { "n", "v" } },
			{ "<leader>t", group = "[T]oggle" },
			{ "<leader>c", group = "[C]ode action", mode = { "n", "v" } },
			{ "<leader>ce", group = "[E]xtract", mode = { "n", "v" } },
			{ "gr", group = "LSP Actions", mode = { "n" } },
		},
	},
}
