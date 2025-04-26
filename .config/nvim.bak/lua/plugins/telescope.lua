return {
  'nvim-telescope/telescope.nvim',
  -- enabled = false,
  -- tag = '0.1.1',
  branch = '0.1.x',
  dependencies = { { 'nvim-lua/plenary.nvim' } },
  -- keys = {
  --   -- local builtin = require('telescope.builtin'),
  --   { '<leader>ff', require('telescope.builtin').find_files }
  config = function()
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>ff", builtin.find_files)
    vim.keymap.set("n", "<leader>fk", builtin.keymaps)
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
  end
}
