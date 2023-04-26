require("nvim-tree").setup({
	git = {
		ignore = false,
	},
})

vim.keymap.set("n", "<leader>t", "<cmd>NvimTreeToggle<cr>")
