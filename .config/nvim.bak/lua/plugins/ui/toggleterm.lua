return {
  'akinsho/toggleterm.nvim',
  lazy = true,
  cmd = { "ToggleTerm", "TermExec" },
  keys = { { "<leader>t", "<cmd>ToggleTerm<CR>" } },
  version = "*",
  opts = {
    direction = 'float',
  },
}
