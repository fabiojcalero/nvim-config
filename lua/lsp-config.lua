-- Setup Mason (LSP installer)
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "pyright", "jdtls" },  -- Auto-install pyright
})

-- Setup autocompletion
local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  preselect = require('cmp').PreselectMode.None,
  completion = {
      completeopt = "menu,menuone,noselect"
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ 
        select = false,
        behavior = cmp.ConfirmBehavior.Replace
    }),
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<Esc>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.abort()
        end
        fallback()
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },  -- LSP completions
    { name = 'buffer' },    -- Text from current buffer
  })
})

-- Setup LSP capabilities for autocompletion
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Configure Python LSP using the new vim.lsp.config API
vim.lsp.config.pyright = {
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'setup.py', 'requirements.txt', '.git' },
  capabilities = capabilities,
}

-- Enable the LSP for Python files
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  callback = function(args)
    vim.lsp.enable('pyright')
    
    -- Set up keybindings when LSP attaches
    local bufnr = args.buf
    local opts = { buffer = bufnr }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)      -- Go to definition
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)            -- Show documentation
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)  -- Rename symbol
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts) -- Code actions
  end,
})

-- Configure Java LSP
vim.lsp.config.jdtls = {
  cmd = { 'jdtls' },
  filetypes = { 'java' },
  root_markers = { 'pom.xml', 'build.gradle', '.git', 'mvnw', 'gradlew' },
  capabilities = capabilities,
}

-- Enable the LSP for Java files
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'java',
  callback = function(args)
    vim.lsp.enable('jdtls')
    
    -- Set up keybindings when LSP attaches
    local bufnr = args.buf
    local opts = { buffer = bufnr }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  end,
})
