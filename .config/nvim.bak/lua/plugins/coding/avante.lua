return {
  "yetone/avante.nvim",
  enabled = false,
  event = "VeryLazy",
  lazy = false,
  version = false, -- set this if you want to always pull the latest change
  dependencies = {
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "hrsh7th/nvim-cmp",                      -- autocompletion for avante commands and mentions
    "nvim-tree/nvim-web-devicons",           -- or echasnovski/mini.icons
    { "zbirenbaum/copilot.lua", opts = {} }, -- for providers='copilot'
    { "zbirenbaum/copilot-cmp", opts = {} },

    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
  opts = {
    provider = "copilot",
    auto_suggestions_provider = "claude",
    ---@type AvanteSupportedProvider
    copilot = {
      endpoint = "https://api.githubcopilot.com",
      model = "gpt-4o-2024-08-06",
      proxy = nil,            -- [protocol://]host[:port] Use this proxy
      allow_insecure = false, -- Allow insecure server connections
      timeout = 30000,        -- Timeout in milliseconds
      temperature = 0,
      max_tokens = 4096,
    },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
}
