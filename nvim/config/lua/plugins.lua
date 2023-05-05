local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.cmd([[packadd packer.nvim]])
end

require("packer").startup({
	function(use)
		use("wbthomason/packer.nvim")

		use("morhetz/gruvbox")

		use("neovim/nvim-lspconfig")

		use("williamboman/mason.nvim")

		use("williamboman/mason-lspconfig.nvim")

		use({
			"rcarriga/nvim-dap-ui",
			requires = { "mfussenegger/nvim-dap" },
		})

		use({
			"kylechui/nvim-surround",
			tag = "*", -- Use for stability; omit to use `main` branch for the latest features
			config = function()
				require("nvim-surround").setup()
			end,
		})

		use({
			"nvim-treesitter/nvim-treesitter",
			run = function()
				require("nvim-treesitter.install").update({ with_sync = true })()
			end,
		})

		use({
			"nvim-treesitter/playground",
			config = function()
				require("nvim-treesitter")
			end,
		})

		use({
			"nvim-telescope/telescope.nvim",
			tag = "0.1.0",
			requires = { { "nvim-lua/plenary.nvim" } },
		})

		use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

		use({
			"lewis6991/gitsigns.nvim",
			config = function()
				require("gitsigns").setup()
			end,
		})

		use({
			"folke/trouble.nvim",
			requires = "kyazdani42/nvim-web-devicons",
			config = function()
				require("trouble").setup({
					-- your configuration comes here
					-- or leave it empty to use the default settings
				})
			end,
		})

		use({
			"nvim-lualine/lualine.nvim",
			requires = { "kyazdani42/nvim-web-devicons", opt = true },
		})

		use("dstein64/vim-startuptime")

		--   use {
		--     'nvim-neorg/neorg',
		--     run = ':Neorg sync-parsers',
		--     config = function()
		--       require('neorg').setup {
		--         load = {
		--           ['core.defaults'] = {},
		-- 	  ['core.norg.dirman'] = {
		--             config = {
		-- 		    workspaces = {
		-- 			    work = '~/notes/work',
		-- 			    home = '~/notes/home'
		-- 		    }
		-- 	    }
		--           },
		-- 	  ['core.integrations.telescope'] = {}
		--         }
		--       }
		--     end,
		--     requires = 'nvim-lua/plenary.nvim'
		--   }

		use({
			"kyazdani42/nvim-tree.lua",
			requires = {
				"kyazdani42/nvim-web-devicons",
			},
		})

		use("hrsh7th/cmp-nvim-lsp")
		use("hrsh7th/cmp-nvim-lsp-signature-help")
		use("hrsh7th/cmp-buffer")
		use("hrsh7th/cmp-path")
		use("hrsh7th/cmp-cmdline")
		use("hrsh7th/nvim-cmp")
		use("L3MON4D3/LuaSnip")
		use("saadparwaiz1/cmp_luasnip")

		use("simrat39/rust-tools.nvim")

		use({
			"saecki/crates.nvim",
			tag = "v0.3.0",
			requires = { "nvim-lua/plenary.nvim" },
			config = function()
				require("crates").setup()
			end,
		})

		use("jose-elias-alvarez/null-ls.nvim")

		use("MunifTanjim/nui.nvim")

		use({
			"mxsdev/nvim-dap-vscode-js",
			requires = { "mfussenegger/nvim-dap" },
		})
		use({
			"microsoft/vscode-js-debug",
			run = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
		})
		use({
			"theHamsta/nvim-dap-virtual-text",
			name = "nvim-dap-virtual-text",
			opts = {
				all_frames = true,
				commented = true,
			},
		})
		use({
			"nvim-telescope/telescope-dap.nvim",
			config = function()
				require("telescope").load_extension("dap")
			end,
		})

		-- Automatically set up configuration after cloning packer.nvim
		if packer_bootstrap then
			require("packer").sync()
		end
	end,
	config = {
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "single" })
			end,
		},
	},
})
