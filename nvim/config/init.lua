require("opts")
require("keys")
require("plugins")

require("mason").setup()

local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup({
	ensure_installed = {
		"rust_analyzer",
		"tsserver",
		"pyright",
		"terraformls",
	},
})

require("lualine").setup({
	options = { theme = "gruvbox" },
})

-- Setup completion
local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")
local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = {
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "path" },
	}, {
		{ name = "buffer", keyword_length = 3 },
	}),
})

-- Setup buffer-local keymaps / options for LSP buffers
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
local lsp_attach = function(client, buf)
	local bmap = function(lhs, rhs, desc)
		vim.keymap.set("n", lhs, rhs, { noremap = true, silent = true, buffer = buf, desc = desc })
	end

	bmap("<leader>qf", vim.diagnostic.setqflist, "Quickfix Diagnostics")
	bmap("[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
	bmap("]d", vim.diagnostic.goto_next, "Next Diagnostic")
	bmap("<leader>e", vim.diagnostic.open_float, "Explain Diagnostic")
	bmap("K", vim.lsp.buf.hover, "Hover Info")
	bmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")
	bmap("<leader>cr", vim.lsp.buf.rename, "Rename Symbol")
	bmap("<leader>fs", vim.lsp.buf.document_symbol, "Document Symbols")
	bmap("<leader>fS", vim.lsp.buf.workspace_symbol, "Workspace Symbols")
	bmap("gr", vim.lsp.buf.references, "References")

	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)

	local bset = vim.api.nvim_buf_set_option
	bset(buf, "formatexpr", "v:lua.vim.lsp.formatexpr()")
	bset(buf, "omnifunc", "v:lua.vim.lsp.omnifunc")
	bset(buf, "tagfunc", "v:lua.vim.lsp.tagfunc")
end

local lspconfig = require("lspconfig")

mason_lspconfig.setup_handlers({
	function(server_name)
		lspconfig[server_name].setup({
			on_attach = lsp_attach,
			capabilities = lsp_capabilities,
		})
	end,
})

require("rust-tools").setup({
	server = {
		capabilities = capabilities,
		on_attach = lsp_attach,
	},
	dap = {
		adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
	},
})
