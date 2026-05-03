return {
	"mfussenegger/nvim-dap",
	optional = true,
	opts = function()
		local dap = require("dap")
		dap.adapters.php = {
			type = "executable",
			command = "php-debug-adapter",
			args = {},
		}
	end,
}
