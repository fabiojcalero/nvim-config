return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").install({ "java", "lua", "vim", "vimdoc", "query" })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "java", "lua", "vim" },
      callback = function()
        pcall(vim.treesitter.start)
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
