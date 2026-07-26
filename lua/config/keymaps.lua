local map = vim.keymap.set

-- Diagnostics
map("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, { desc = "Prev diagnostic" })
map("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, { desc = "Next diagnostic" })
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Line diagnostics" })

-- LSP keymaps applied on attach (works for all servers including jdtls)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufmap = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = args.buf, desc = desc })
    end
    bufmap("n", "gd", vim.lsp.buf.definition, "Go to definition")
    bufmap("n", "gr", vim.lsp.buf.references, "References")
    bufmap("n", "gi", vim.lsp.buf.implementation, "Implementation")
    bufmap("n", "K", vim.lsp.buf.hover, "Hover")
    bufmap("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
    bufmap("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
    bufmap("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, "Format")
  end,
})
