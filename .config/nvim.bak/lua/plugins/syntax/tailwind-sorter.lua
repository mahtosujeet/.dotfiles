return {
  'laytan/tailwind-sorter.nvim',
  lazy = true,
  -- enabled = false,
  ft = { 'html', 'css', 'jsx', 'tsx' },
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-lua/plenary.nvim' },
  build = 'cd formatter && npm i && npm run build',
  config = function()
    require('tailwind-sorter').setup({
      on_save_enabled = true,                                                                         -- If `true`, automatically enables on save sorting.
      on_save_pattern = { '*.html', '*.js', '*.jsx', '*.tsx', '*.twig', '*.hbs', '*.php', '*.heex' }, -- The file patterns to watch and sort.
      node_path = 'node',
    })
  end
}
