-- Hide the status line completely
vim.opt.laststatus = 0

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Number width
vim.opt.numberwidth = 1

-- Mouse
vim.opt.mouse = ""

-- Auto-indentation
vim.opt.autoindent = true

-- Tabs and indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.smarttab = true

-- Case sensitivity
vim.opt.smartcase = true

-- Expand tab to spaces
vim.opt.expandtab = true

-- Encoding
vim.opt.encoding = "utf-8"

-- Clipboard
vim.opt.clipboard:append("unnamedplus")
