vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- tabs & indentation opt.tabstop = 4 -- 4 spaces for tabs
opt.shiftwidth = 4 -- 4 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indentation from current line to new line

opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true -- if the search is mixed case, use case sensitive search

-- add colors
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes" -- show sign clumn which is a margin to show icons for things like errors and breakpoints

-- backspace
opt.backspace = "indent,eol,start" -- make backspace intuitive again

-- split windows
opt.splitright = true -- split vertical windows to the right
opt.splitbelow = true -- split horizontal window to the bottom
