require 'opts'
require 'keys'
require 'plug'

require('mason').setup()

require('mason-lspconfig').setup()

require('telescope').load_extension('fzf')

require('lualine').setup {
  options = { theme = 'gruvbox' }
}

require("nvim-tree").setup()

-- Setup completion
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require('luasnip')
local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { 'i', 's' }),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'path' },
  }, {
    { name = 'buffer', keyword_length = 3 },
  }),
})


-- Setup buffer-local keymaps / options for LSP buffers
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
local lsp_attach = function(client, buf)
  local bmap = function(lhs, rhs, desc)
    vim.keymap.set("n", lhs, rhs, { noremap=true, silent=true, buffer=buf, desc=desc })
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

  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)

  local bset = vim.api.nvim_buf_set_option
	bset(buf, "formatexpr", "v:lua.vim.lsp.formatexpr()")
	bset(buf, "omnifunc", "v:lua.vim.lsp.omnifunc")
	bset(buf, "tagfunc", "v:lua.vim.lsp.tagfunc")
end

local extension_path = vim.env.XDG_DATA_HOME .. '/nvim/mason/packages/codelldb/extension/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.dylib'

-- DAP
local dap = require('dap')
dap.adapters.lldb = {
  type = 'executable',
  command = codelldb_path,
  name = 'lldb'
}

-- DAP UI
local dapui = require("dapui")
dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

local map = vim.keymap.set
local opt = { noremap = true, silent = true }
map('n', '<f5>', "<cmd>lua require'dap'.continue()<cr>", opt)
map('n', '<f10>', "<cmd>lua require'dap'.step_over()<cr>", opt)
map('n', '<f11>', "<cmd>lua require'dap'.step_into()<cr>", opt)
map('n', '<f12>', "<cmd>lua require'dap'.step_out()<cr>", opt)
map('n', '<leader>db', "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opt)
map('n', '<leader>dB', "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", opt)
map('n', '<leader>dm', "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>", opt)
map('n', '<leader>dr', "<cmd>lua require'dap'.repl.open()<cr>", opt)
map('n', '<leader>dl', "<cmd>lua require'dap'.run_last()<cr>", opt)

-- RUST
dap.configurations.rust = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
  }
}

require("rust-tools").setup({
	server = {
		capabilities = capabilities,
		on_attach = lsp_attach,
	},
  dap = {
    adapter = require('rust-tools.dap').get_codelldb_adapter(
      codelldb_path,
      liblldb_path
    )
  },
})

local lspconfig = require('lspconfig')

lspconfig.tsserver.setup({
  capabilities = capabilities,
  on_attach = lsp_attach,
})

vim.api.nvim_command [[colorscheme gruvbox]]

