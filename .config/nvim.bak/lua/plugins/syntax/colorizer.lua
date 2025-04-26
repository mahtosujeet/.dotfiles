return {
  'norcalli/nvim-colorizer.lua',
  event = "BufEnter",
  config = function()
    require('colorizer').setup()
  end
}
