local home = vim.env.HOME
local mason_jdtls = home .. "/.local/share/nvim/mason/packages/jdtls"
local workspace_path = home .. "/.local/share/nvim/jdtls-workspace/"

local function jdtls_data_dir(root_dir)
	local project_name = root_dir and vim.fn.fnamemodify(root_dir, ":p:h:t")
		or vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
	return workspace_path .. project_name
end

local function jdtls_cmd(dispatchers, config)
	local config_cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-javaagent:" .. mason_jdtls .. "/lombok.jar",
		"-jar",
		vim.fn.glob(mason_jdtls .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
		"-configuration",
		mason_jdtls .. "/config_linux",
		"-data",
		jdtls_data_dir(config.root_dir),
	}

	return vim.lsp.rpc.start(config_cmd, dispatchers, {
		cwd = config.cmd_cwd,
		env = config.cmd_env,
		detached = config.detached,
	})
end

return {
	"mfussenegger/nvim-jdtls",
	dependencies = {
		"neovim/nvim-lspconfig",
		"mason-org/mason.nvim",
	},
	config = function()
		vim.lsp.config("jdtls", {
			cmd = jdtls_cmd,
			filetypes = { "java" },
			root_markers = { ".git", "mvnw", "gradlew", "pom.xml" },
			init_options = {
				bundles = {},
				extendedClientCapabilities = require("jdtls.capabilities"),
			},
			settings = {
				java = {
					signatureHelp = { enabled = true },
					maven = {
						downloadSources = true,
					},
					referencesCodeLens = {
						enabled = true,
					},
					references = {
						includeDecompiledSources = true,
					},
					inlayHints = {
						parameterNames = {
							enabled = "all",
						},
					},
					format = {
						enabled = false,
					},
					completion = {
						favoriteStaticMembers = {
							"org.hamcrest.MatcherAssert.assertThat",
							"org.hamcrest.Matchers.*",
							"org.hamcrest.CoreMatchers.*",
							"org.junit.jupiter.api.Assertions.*",
							"java.util.Objects.requireNonNull",
							"java.util.Objects.requireNonNullElse",
							"org.mockito.Mockito.*",
						},
						filteredTypes = {
							"com.sun.*",
							"io.micrometer.shaded.*",
							"java.awt.*",
							"jdk.*",
							"sun.*",
						},
					},
					configuration = {
						runtimes = {
							{
								name = "JavaSE-21",
								path = home .. "/.sdkman/candidates/java/21.0.11-tem",
							},
							{
								name = "JavaSE-17",
								path = home .. "/.sdkman/candidates/java/17.0.19-tem",
							},
						},
					},
				},
			},
		})
		vim.lsp.enable("jdtls")

		vim.keymap.set("n", "<leader>co", "<Cmd>lua require'jdtls'.organize_imports()<CR>", { desc = "organize imports" })
		vim.keymap.set("n", "<leader>cev", "<Cmd>lua require('jdtls').extract_variable()<CR>", { desc = "extract variable" })
		vim.keymap.set("v", "<leader>cev", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", { desc = "extract variable" })
		vim.keymap.set("n", "<leader>cec", "<Cmd>lua require('jdtls').extract_constant()<CR>", { desc = "extract constant" })
		vim.keymap.set("v", "<leader>cec", "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", { desc = "extract constant" })
		vim.keymap.set("v", "<leader>cem", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", { desc = "extract method" })
	end,
}
