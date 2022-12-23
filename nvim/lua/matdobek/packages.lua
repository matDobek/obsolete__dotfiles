-- Auto install pakcer.nvim
local install_path = vim.fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({"git", "clone", "https://github.com/wbthomason/packer.nvim", install_path})
end

vim.cmd.packadd("packer.nvim")

require("packer").startup(function(use)
  -- Packer can manage itself
  use "wbthomason/packer.nvim"

  use {
	  "nvim-telescope/telescope.nvim", tag = "0.1.0",
	  -- or                            , branch = "0.1.x",
	  requires = { {"nvim-lua/plenary.nvim"} }
  }

  use({"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"})

  use {
	  "VonHeikemen/lsp-zero.nvim",
	  requires = {
		  -- LSP Support
		  {"neovim/nvim-lspconfig"},
		  {"williamboman/mason.nvim"},
		  {"williamboman/mason-lspconfig.nvim"},

		  -- Autocompletion
		  {"hrsh7th/nvim-cmp"},
		  {"hrsh7th/cmp-buffer"},
		  {"hrsh7th/cmp-path"},
		  {"saadparwaiz1/cmp_luasnip"},
		  {"hrsh7th/cmp-nvim-lsp"},
		  {"hrsh7th/cmp-nvim-lua"},

		  -- Snippets
		  {"L3MON4D3/LuaSnip"},
		  {"rafamadriz/friendly-snippets"},
	  }
  }

  use({ "nvim-tree/nvim-tree.lua", requires = { "nvim-tree/nvim-web-devicons" } })

  use("github/copilot.vim")
  use("aduros/ai.vim")

  use("numToStr/Navigator.nvim")

  use("folke/zen-mode.nvim")
  use("godlygeek/tabular")
  use("nvim-lualine/lualine.nvim")
  use("terrortylor/nvim-comment")
  use("windwp/nvim-autopairs")

  -- themes
  use("cideM/yui")
  use("folke/tokyonight.nvim")
  use("nikolvs/vim-sunbather")
  use({"rose-pine/neovim", as = "rose-pine" })
end)
