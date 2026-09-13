return {
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Mason must be loaded before its dependents so we need to set it up here.
		-- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
		{ "mason-org/mason.nvim", opts = {} },

		-- Maps LSP server names between nvim-lspconfig and Mason package names.
		-- NOTE: intentionally not set up (no `opts`): its `automatic_enable` default would
		--  enable every Mason-installed server, including the jdtls config in plugins/jdtls.lua.
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		-- Useful status updates for LSP.
		{ "j-hui/fidget.nvim", opts = {} },
	},
	config = function()
		local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
			callback = function(event)
				-- NOTE: grn, gra, gri, grr, grt, grx, gO and K are global defaults, see `:h lsp-defaults`
				vim.keymap.set("n", "grD", vim.lsp.buf.declaration, {
					buffer = event.buf,
					desc = "lsp: goto declaration",
				})

				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client:supports_method("textDocument/documentHighlight", event.buf) then
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})
				end

				if client and client:supports_method("textDocument/inlayHint", event.buf) then
					vim.keymap.set("n", "<leader>th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
					end, { buffer = event.buf, desc = "lsp: toggle inlay hints" })
				end
			end,
		})

		vim.api.nvim_create_autocmd("LspDetach", {
			group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
			callback = function(event)
				vim.lsp.buf.clear_references()
				vim.api.nvim_clear_autocmds({ group = highlight_augroup, buffer = event.buf })
			end,
		})

		local servers = { "intelephense", "lua_ls", "ts_ls", "twiggy_language_server" }

		-- NOTE: `cmd`, `filetypes` and `root_markers` come from nvim-lspconfig's `lsp/*.lua`
		--  definitions, so only servers needing an override are configured here.
		--  See `:h lsp-config-merge`.
		vim.lsp.config("intelephense", {
			settings = {
				intelephense = {
					diagnostics = {
						undefinedProperties = false,
					},
				},
			},
			root_markers = { "composer.json" },
		})

		vim.lsp.config("lua_ls", {
			on_init = function(client)
				client.server_capabilities.documentFormattingProvider = false -- Disable formatting (formatting is done by stylua)

				if client.workspace_folders then
					local path = client.workspace_folders[1].name
					if
						path ~= vim.fn.stdpath("config")
						and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
					then
						return
					end
				end

				client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
					runtime = {
						version = "LuaJIT",
						path = { "lua/?.lua", "lua/?/init.lua" },
					},
					workspace = {
						checkThirdParty = false,
						-- NOTE: VIMRUNTIME alone covers the whole `vim.*` API (including vim.uv).
						--  Adding all of 'runtimepath' is much slower and breaks editing this config.
						--  See https://github.com/neovim/nvim-lspconfig/issues/3189
						library = { vim.env.VIMRUNTIME },
					},
				})
			end,
		})

		vim.lsp.enable(servers)

		-- Install the servers above, plus additional tools (linters, formatters, DAPs)
		require("mason-tool-installer").setup({
			ensure_installed = vim.list_extend(vim.deepcopy(servers), {
				"jdtls",
				"java-debug-adapter",
				"java-test",
				"markdownlint-cli2",
				"phpcs",
				"php-cs-fixer",
				"stylua",
				"twigcs",
			}),
		})
	end,
}
