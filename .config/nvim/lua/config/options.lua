-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.relativenumber = false -- Show relative line numbers

vim.opt.clipboard = ""

-- Tab and indentation settings
local tablength = 2

vim.opt.tabstop = tablength -- Number of spaces that a <Tab> in the file counts for
vim.opt.softtabstop = tablength -- Number of spaces that a <Tab> counts for while performing editing operations
vim.opt.shiftwidth = tablength -- Number of spaces to use for each step of (auto)indent
vim.opt.expandtab = true -- Use spaces instead of tabs

-- Line wrapping settings
vim.opt.wrap = true -- Enable line wrapping
vim.opt.linebreak = true -- Wrap lines at convenient points
vim.g.ai_cmp = true
vim.lsp.handlers["textDocument/inlayHint"] = function() end
