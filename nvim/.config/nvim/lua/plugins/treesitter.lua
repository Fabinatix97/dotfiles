return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	opts = {
		ensure_installed = {
			"c",
			"java",
			"javascript",
			"help",
			"lua",
			"php",
			"rust",
            "twig",
			"typescript",
		},
	},
}
