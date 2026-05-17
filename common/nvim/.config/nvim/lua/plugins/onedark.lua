return {
  "navarasu/onedark.nvim",
  lazy = false,
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    require('onedark').setup {
      style = 'darker'
    }
    -- Enable theme
    require('onedark').load()
    vim.api.nvim_set_hl(0, 'ColorColumn', { bg = '#3a3f4b' })
  end
}
