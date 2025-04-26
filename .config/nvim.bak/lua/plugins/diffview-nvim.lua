return {
  "sindrets/diffview.nvim",
  lazy = true,
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open Git diff view" },
    { "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "Close Git diff view" },
    { "<leader>gt", "<cmd>DiffviewToggleFiles<cr>", desc = "Toggle diff file panel" },
    { "<leader>gf", "<cmd>DiffviewFocusFiles<cr>", desc = "Focus diff file panel" },
  },
  config = function()
    -- For dotfiles
    -- vim.env.GIT_WORK_TREE = vim.fn.expand("~")
    -- vim.env.GIT_DIR = vim.fn.expand("~/.dotfiles")
  end
}
