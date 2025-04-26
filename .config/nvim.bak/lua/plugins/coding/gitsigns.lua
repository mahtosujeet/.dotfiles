return {
  "lewis6991/gitsigns.nvim",
  event = "BufEnter",
  config = true,
  keys = {
    { "<leader>hp", "<cmd>Gitsigns preview_hunk_inline<cr>",       desc = "Preview hunk inline" },
    { "<leader>hn", "<cmd>Gitsigns next_hunk<cr>",                 desc = "Go to next hunk" },
    { "<leader>hr", "<cmd>Gitsigns reset_hunk<CR>",                desc = "Reset hunk" },
    { "<leader>hR", "<cmd>Gitsigns reset_buffer<CR>",              desc = "Reset buffer" },
    { "<leader>hd", "<cmd>Gitsigns diffthis<CR>",                  desc = "Show diff" },
    { "<leader>hb", "<cmd>Gitsigns toggle_current_line_blame<CR>", desc = "Toggle current line blame" },
  },
}
