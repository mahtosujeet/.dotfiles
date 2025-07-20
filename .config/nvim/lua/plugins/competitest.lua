return {
  "xeluxee/competitest.nvim",
  dependencies = "MunifTanjim/nui.nvim",
  config = function()
    require("competitest").setup({
      compile_directory = ".",
      compile_command = {
        c = {
          exec = "bash",
          args = { "-c", '[[ ! -d "./tests" ]] && mkdir -p "./tests"; gcc -Wall "$(FNAME)" -o "./tests/$(FNOEXT)"' },
        },
        cpp = {
          exec = "bash",
          args = { "-c", '[[ ! -d "./tests" ]] && mkdir -p "./tests"; g++ -Wall "$(FNAME)" -o "./tests/$(FNOEXT)"' },
          -- args = { "-Wall", "$(FNAME)", "-o", "./tests/$(FNOEXT)" },
        },
      },
      running_directory = "./tests",
      testcases_directory = "./tests",
      -- testcases_use_single_file = false
    })

    local set = vim.keymap.set
    local file = "dolphin"

    set("n", "<leader>pr", "<cmd>CompetiTest run<CR>", { desc = "Run testcases" })
    set("n", "<leader>pt", "<cmd>CompetiTest receive testcases<CR>", { desc = "Receive testcases" })
    set("n", "<leader>pp", "<cmd>CompetiTest receive problem<CR>", { desc = "Receive problem" })
    set("n", "<leader>pc", "<cmd>CompetiTest receive contest<CR>", { desc = "Receive contest" })
    set("n", "<leader>pa", "<cmd>CompetiTest add_testcase<CR>", { desc = "Add testcase" })
    set("n", "<leader>pe", "<cmd>CompetiTest edit_testcase<CR>", { desc = "Edit testcase" })
    set("n", "<leader>ps", "<cmd>!" .. file .. " .&<CR>", { desc = "Open thunar" })
  end,
}
