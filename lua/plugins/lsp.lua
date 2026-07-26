return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("mason-lspconfig").setup({
        -- jdtls intentionally NOT auto-set-up here; nvim-jdtls handles it
        ensure_installed = { "lua_ls" },
        handlers = {
          function(server)
            require("lspconfig")[server].setup({
              capabilities = require("cmp_nvim_lsp").default_capabilities(),
            })
          end,
          jdtls = function() end, -- no-op, disable lspconfig's jdtls
        },
      })
    end,
  },
  -- Ensure jdtls binary + java debug adapters are installed via Mason
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason.nvim" },
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = { "jdtls", "java-debug-adapter", "java-test" },
      })
    end,
  },
}
