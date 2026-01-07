-- Disable netrw (Vim's built-in file explorer) to avoid conflicts
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Setup nvim-tree
require("nvim-tree").setup({
  -- Sort files/folders naturally (1, 2, 10 instead of 1, 10, 2)
  sort = {
    sorter = "case_sensitive",
  },
  -- How the tree looks
  view = {
    width = 40,  -- Width of the tree window
    relativenumber = true,
  },
  -- Show hidden files (files starting with .)
  filters = {
    dotfiles = false,  -- Set to true to hide dotfiles
  },
  -- Git integration
  git = {
    enable = true,
    ignore = false,  -- Show files in .gitignore
  },
  -- File system watcher (auto-refresh when files change)
  filesystem_watchers = {
    enable = true,
  },
  -- What to do when opening a file
  actions = {
    open_file = {
      quit_on_open = false,  -- Keep tree open after opening a file
      window_picker = {
        enable = false,  -- Allow picking which window to open file in
      },
    },
  },
})

-- Keybindings for nvim-tree
vim.keymap.set('n', '<leader>ee', '<cmd>NvimTreeToggle<CR>', { desc = 'Toggle file explorer' })
vim.keymap.set('n', '<leader>ef', '<cmd>NvimTreeFindFile<CR>', { desc = 'Find current file in explorer' })
vim.keymap.set('n', '<leader>er', '<cmd>NvimTreeRefresh<CR>', { desc = 'Refresh file explorer' })
