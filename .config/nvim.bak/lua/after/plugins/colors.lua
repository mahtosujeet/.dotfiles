-- vim.cmd.colorscheme("gruvbox")
-- vim.cmd.colorscheme("tokyonight")
-- vim.cmd.colorscheme("rose-pine")
-- vim.cmd.colorscheme("catppuccin")
function ColorMyPencils(color)
  -- color = color or "tokyonight"
  -- color = color or "gruvbox"
  color = color or "gruvbox-material"

  vim.cmd.colorscheme(color)

  -- false if neovide, else true
  local transparent = not (vim.g.neovide)

  -- To make bg transparent
  if (transparent) then
    local bg_color = vim.api.nvim_get_hl_by_name("Normal", true).background
    bg_color = string.format("#%06x", bg_color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })            -- 0 means global
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })       -- 0 means global
    vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = bg_color }) -- 0 means global


    -- not working
    vim.api.nvim_set_hl(0, "ToggleTermNormal", { bg = bg_color })       -- 0 means global
    vim.api.nvim_set_hl(0, "ToggleTermNormalFloat", { bg = bg_color })  -- 0 means global
    vim.api.nvim_set_hl(0, "ToggleTerm1NormalFloat", { bg = bg_color }) -- 0 means global
    vim.api.nvim_set_hl(0, "ToggleTermFloatBorder", { bg = bg_color })  -- 0 means global
    vim.api.nvim_set_hl(0, "TerminalNormal", { bg = bg_color })         -- 0 means global
  end
end

ColorMyPencils()
