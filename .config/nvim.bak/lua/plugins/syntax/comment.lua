return {
  "numToStr/Comment.nvim",
  config = function()
    require('Comment').setup()

    vim.api.nvim_set_keymap('n', '<C-/>', 'gcc', {})
  end

}
