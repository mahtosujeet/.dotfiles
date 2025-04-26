return {
  "rcarriga/nvim-notify",
  enabled = false,
  config = function()
    local notifier = require("notify")
    notifier.setup({
      timeout = 5000,
      background_colour = "#000000",
    })
    vim.notify = notifier
  end
}
