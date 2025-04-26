return {
  'xeluxee/competitest.nvim',
  dependencies = 'MunifTanjim/nui.nvim',
  config = function()
    require('competitest').setup({
      testcases_use_single_file = true,
    })

    local set = vim.keymap.set

    set('n', '<leader>cr', "<cmd>CompetiTest run<CR>")
    set('n', '<leader>ct', "<cmd>CompetiTest receive testcases<CR>")
    set('n', '<leader>cp', "<cmd>CompetiTest receive problem<CR>")
    set('n', '<leader>cc', "<cmd>CompetiTest receive contest<CR>")
  end
}
