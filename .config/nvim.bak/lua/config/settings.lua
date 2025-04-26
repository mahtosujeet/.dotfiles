-- General settings
vim.opt.termguicolors = true   -- Enable 24-bit RGB colors
vim.opt.number = true          -- Show line numbers
vim.opt.relativenumber = false -- Show relative line numbers
vim.opt.cursorline = true      -- Highlight the current line

-- Search settings
vim.opt.ignorecase = true -- Ignore case in search patterns
vim.opt.smartcase = true  -- Override ignorecase if search pattern contains uppercase letters
vim.opt.hlsearch = false  -- Do not highlight search results
vim.opt.incsearch = true  -- Show search results as you type

-- Tab and indentation settings
local tablength = 2
vim.opt.tabstop = tablength     -- Number of spaces that a <Tab> in the file counts for
vim.opt.softtabstop = tablength -- Number of spaces that a <Tab> counts for while performing editing operations
vim.opt.shiftwidth = tablength  -- Number of spaces to use for each step of (auto)indent
vim.opt.expandtab = true        -- Use spaces instead of tabs

-- Line wrapping settings
vim.opt.wrap = true      -- Enable line wrapping
vim.opt.linebreak = true -- Wrap lines at convenient points
vim.opt.scrolloff = 10   -- Minimum number of screen lines to keep above and below the cursor

-- Neovide settings
-- if vim.g.neovide then
-- vim.g.neovide_scale_factor = 0.85
-- vim.g.neovide_transparency = 0.95
-- end

-- Code folding settings
-- By default all the foldings are open
-- close all = zM
-- toggle one = za
-- open all = zR
-- vim.opt.foldmethod = "expr"   -- Set fold method to expression
-- vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- Use Treesitter for folding
-- vim.opt.foldlevel = 999       -- Open all folds by default
-- vim.opt.foldnestmax = 4

vim.g.mapleader = " "
