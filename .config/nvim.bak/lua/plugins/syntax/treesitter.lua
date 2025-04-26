return {
  'nvim-treesitter/nvim-treesitter',
  event = "BufEnter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "windwp/nvim-ts-autotag",
  },
  build = ':TSUpdate',
  config = function()
    require 'nvim-treesitter.configs'.setup {
      ensure_installed = { "javascript", "lua", "html", "css", "gitignore" },

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      auto_install = true,

      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      autotag = {
        enable = true,
      },

      -- incremental_selection = {
      --   keymaps = {
      --     init_selection = "<leader>ss",
      --     node_incremental = "<leader>si",
      --     scope_incremental = "<leader>sc",
      --     node_decremental = "<leader>sd"
      --   },
      -- },

      textobjects = {
        -- select = {
        --   enable = true,
        --   lookahead = true,

        --   -- keymaps = {
        --   --   -- You can use the capture groups defined in textobjects.scm
        --   --   ["af"] = "@function.outer",
        --   --   ["if"] = "@function.inner",
        --   --   ["ac"] = "@class.outer",
        --   --   ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
        --   -- },

        --   -- default is "v"
        --   -- selection_modes = {
        --   --   ['@parameter.outer'] = 'v', -- charwise
        --   --   ['@function.outer'] = 'V', -- linewise
        --   --   ['@class.outer'] = '<c-v>', -- blockwise
        --   -- },
        --   -- If you set this to `true` (default is `false`) then any textobject is
        --   -- extended to include preceding or succeeding whitespace. Succeeding
        --   -- whitespace has priority in order to act similarly to eg the built-in
        --   -- `ap`.
        --   --
        --   -- Can also be a function which gets passed a table with the keys
        --   -- * query_string: eg '@function.inner'
        --   -- * selection_mode: eg 'v'
        --   -- and should return true or false
        --   include_surrounding_whitespace = true,
        -- },

        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]]"] = "@function.outer",
            --
            ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
            ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
          },
          goto_previous_start = {
            ["[["] = "@function.outer",
            ["[s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
            ["[z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
          },

          goto_next = {
            ["]c"] = "@conditional.outer",
          },
          goto_previous = {
            ["[c"] = "@conditional.outer",
          }
        },
      },
    }
  end
}
