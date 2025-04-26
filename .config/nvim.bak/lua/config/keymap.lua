local set = vim.keymap.set

-- set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
-- set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })

-- Better window movement
set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
set("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
set("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Resize with arrows
set("n", "<C-Up>", ":resize -2<CR>", { desc = "Resize window up" })
set("n", "<C-Down>", ":resize +2<CR>", { desc = "Resize window down" })
set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Resize window left" })
set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Resize window right" })

-- Save the buffer
set("n", "<C-s>", ":w<CR>", { desc = "Save buffer" })
set("i", "<C-s>", "<Esc>:w<CR>", { desc = "Save buffer in insert mode" })
set("n", "<leader>q", ":q!<CR>", { desc = "Quit without saving" })

-- Open config file
set("n", "<leader>nc", ":tabnew $HOME/.config/nvim/<CR>", { desc = "Open Neovim config" })

-- git
set("n", "<leader>gb", ":Gitsigns blame<CR>", { desc = "View git blame-line" })

-- Function to run the command based on filetype
function RunCode()
  local filetype = vim.bo.filetype
  local commands = {
    python = 'python %',
    c = 'gcc % && ./a.out',
    cpp = 'g++ % && ./a.out',
    asm = 'gcc % -nostdlib -static && ./a.out',
    sh = 'if [ ! -x % ]; then chmod +x %; fi; ./%',
    javascript = 'node %',
    typescript = 'node %',
    rust = 'rustc % && ./a.out',
    lua = 'lua %',
    markdown = 'pandoc % -o %:r.html',
    json = 'jq . %',
    -- For latex files
    latex = 'latexmk -pdf %',
  }

  local command = commands[filetype]
  if command then
    vim.cmd("w")
    vim.cmd("TermExec cmd='" .. command .. "'")
  else
    print('No run command set for this filetype')
  end
end

-- Key mapping to run code
set("n", "<leader>r", ":lua RunCode()<CR>", { desc = "Run code based on filetype" })
set('n', "<C-'>", ':lua RunCode()<CR>', { noremap = true, silent = true })
