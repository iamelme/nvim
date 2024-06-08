return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "tsserver", "tailwindcss", "html", "emmet_ls" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function(ev)
			local lspconfig = require("lspconfig")
			local cmp_nvim_lsp = require("cmp_nvim_lsp")

			local on_attach = function(client, bufnr)
				-- local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

				local function buf_set_option(...)
					vim.api.nvim_buf_set_option(bufnr, ...)
				end

				buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
				-- local opts = { noremap = true, silent = true }
				--
				-- buf_set_keymap('n', 'gD', '<cmd>Telescope lsp_type_definitions<CR>', opts)
				-- buf_set_keymap('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)
				-- buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
				-- buf_set_keymap('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
				-- buf_set_keymap('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)
				-- buf_set_keymap('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
				-- buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
				-- buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
				-- buf_set_keymap('n', '<leader>ll', '<cmd>lua vim.lsp.codelens.run()<cr>', opts)
				client.server_capabilities.document_formatting = true
			end

			-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
			capabilities.textDocument.completion.completionItem.snippetSupport = true
			-- capabilities.textDocument.completion.completionItem.snippetSupport = true
			-- local capabilities = vim.tbl_deep_extend(
			--   "force",
			--   vim.lsp.protocol.make_client_capabilities(),
			--   require("cmp_nvim_lsp").default_capabilities()
			-- )

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})

			lspconfig.tsserver.setup({
				capabilities = capabilities,
			})

			lspconfig.html.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})

			lspconfig.tailwindcss.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" },
				root_dir = lspconfig.util.root_pattern(
					"tailwind.config.js",
					"tailwind.config.ts",
					"tailwind.config.lua"
				),
			})

			-- lspconfig.emmet_language_server.setup({})
			lspconfig.emmet_ls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = {
					"css",
					"html",
					"javascript",
					"javascriptreact",
					"less",
					"sass",
					"scss",
					"typescriptreact",
				},
				init_options = {
					html = {
						options = {
							-- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
							["bem.enabled"] = true,
						},
					},
				},
			})

			local opts = { buffer = ev.buf }
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
			vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
			vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
			vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
			vim.keymap.set("n", "<leader>wl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, opts)
			vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
			vim.keymap.set({ "n", "v" }, "<leader>.", vim.lsp.buf.code_action, opts)
			vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
			vim.keymap.set("n", "<leader>f", function()
				vim.lsp.buf.format({ async = true })
			end, opts)
			-- local lsp_group = vim.api.nvim_create_augroup("lspconfig", {})

			-- vim.api.nvim_create_augroup({
			--   "BufEnter",
			--   "BufWritePost",
			--   "InsertLeave",
			-- }, {
			--   callback = function()
			--       vim.lsp.buf.format({async= true})
			--   end,
			-- })
		end,
	},
}
