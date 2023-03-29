local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local null_ls = require("null-ls")
local command_resolver = require("null-ls.helpers.command_resolver")

null_ls.setup({
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						bufnr = bufnr,
						filter = function(client)
							return client.name == "null-ls"
						end,
					})
				end,
			})
		end
	end,
	debug = true,
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.prettier.with({
			dynamic_command = command_resolver.from_yarn_pnp(),
			condition = function(utils)
				return utils.root_has_file(".pnp.cjs")
			end,
		}),
		null_ls.builtins.formatting.prettierd.with({
			condition = function(utils)
				return not utils.root_has_file(".pnp.cjs")
			end,
		}),
		null_ls.builtins.diagnostics.eslint_d.with({
			command = "yarn",
			args = { "eslint", "-f", "json", "--stdin", "--stdin-filename", "$FILENAME" },
			condition = function(utils)
				return utils.root_has_file(".pnp.cjs")
			end,
		}),
		null_ls.builtins.diagnostics.eslint_d.with({
			condition = function(utils)
				return not utils.root_has_file(".pnp.cjs")
			end,
		}),
		null_ls.builtins.completion.spell,
	},
})
