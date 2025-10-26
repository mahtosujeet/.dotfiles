-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local set = vim.keymap.set

function RunCode()
  local filetype = vim.bo.filetype
  local filepath = vim.fn.expand("%")
  local commands = {
    python = 'python "' .. filepath .. '"',
    c = 'gcc "' .. filepath .. '" && ./a.out',
    cpp = 'g++ "' .. filepath .. '" && ./a.out',
    asm = 'gcc "' .. filepath .. '" -nostdlib -static && ./a.out',
    sh = 'if [ ! -x "' .. filepath .. '" ]; then chmod +x ' .. filepath .. '; fi; ./' .. filepath,
    javascript = 'node ' .. filepath,
    typescript = 'node ' .. filepath,
    rust = 'rustc ' .. filepath .. ' && ./a.out',
    lua = 'lua ' .. filepath,
    markdown = 'pandoc ' .. filepath .. ' -o ' .. vim.fn.expand('%:r') .. '.html',
    json = 'jq . ' .. filepath,
    -- For latex files
    latex = 'latexmk -pdf ' .. filepath,
    java = 'mkdir -p output && javac -d output "' .. filepath .. '" && java -cp output ' .. vim.fn.expand('%:t:r'),
  }

  local command = commands[filetype]
  if command then
    vim.cmd("w")
    -- vim.cmd("TermExec cmd='" .. command .. "'")
    Snacks.terminal(command, { auto_close = false })
  else
    print("No run command set for this filetype")
  end
end

-- Key mapping to run code
set("n", "<leader>r", ":lua RunCode()<CR>", { desc = "Run code based on filetype" })
set("n", "<C-'>", ":lua RunCode()<CR>", { noremap = true, silent = true })
