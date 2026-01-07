-- Bootstrap lazy.nvim (auto-install if not present)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Setup plugins
require("lazy").setup({
  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",           -- Easy LSP installer
      "williamboman/mason-lspconfig.nvim", -- Bridge between mason and lspconfig
    }
  },
  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",  -- LSP completion source
      "hrsh7th/cmp-buffer",     -- Buffer completion source
      "L3MON4D3/LuaSnip",       -- Snippet engine
    }
  },
  -- Vim-tmux navigator
  {
     "christoomey/vim-tmux-navigator",
     lazy = false,
  },
  -- File explorer (nvim-tree)
  {
      "nvim-tree/nvim-tree.lua",
      dependencies = {
          "nvim-tree/nvim-web-devicons", -- Optional: for file icons
      },
      config = function()
          require("nvim-tree-config")
      end,
  }
})

