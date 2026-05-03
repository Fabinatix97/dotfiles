return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	opts = {
		ensure_installed = {
			"help",
			"javascript",
			"typescript",
			"c",
			"lua",
			"rust",
			"php",
			"java",
		},
	},
}
