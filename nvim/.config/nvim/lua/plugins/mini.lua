return {
	format_on_save = function(bufnr)
		-- You can specify filetypes to autoformat on save here:
		local enabled_filetypes = {
			-- lua = true,
			-- python = true,
		}
		if enabled_filetypes[vim.bo[bufnr].filetype] then
			return { timeout_ms = 500 }
		else
			return nil
		end
	end,
	"nvim-mini/mini.nvim",
	config = function()
		require("mini.ai").setup({
			mappings = {
				around_next = "aa",
				inside_next = "ii",
			},
			n_lines = 500,
		})

		require("mini.surround").setup()

		local statusline = require("mini.statusline")
		statusline.setup({ use_icons = vim.g.have_nerd_font })
		statusline.section_location = function()
			return "%2l:%-2v"
		end
	end,
}
