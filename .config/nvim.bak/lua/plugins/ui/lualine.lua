return {
  'nvim-lualine/lualine.nvim',
  event = "VimEnter",
  dependencies = { 'nvim-tree/nvim-web-devicons', opts = true },
  opts = {
    sections = {
      lualine_x = {
        {
          function()
            local msg = 'No Active Lsp'
            local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
            local clients = vim.lsp.get_clients()
            if next(clients) == nil then
              return msg
            end
            for _, client in ipairs(clients) do
              local filetypes = client.config.filetypes
              if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                return client.name
              end
            end
            return msg
          end,
          icon = ' LSP:',
        },
        'encoding',
        'fileformat',
      },
    },
  },
}
