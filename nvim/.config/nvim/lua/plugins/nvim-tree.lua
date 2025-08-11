-- Custom on attach handler to define the key bindings
local function nvim_tree_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return {
      desc = "nvim-tree: " .. desc,
      buffer = bufnr,
      noremap = true,
      silent = true,
      nowait = true
    }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent,  opts('Up'))
  vim.keymap.set('n', '?', api.tree.toggle_help,                opts('Help'))
  vim.keymap.set('n', 't', api.node.open.tab,                   opts('Open: New Tab'))
  vim.keymap.set('n', 'v', api.node.open.vertical,              opts('Open: Vertical Split'))
  vim.keymap.set('n', 's', api.node.open.horizontal,            opts('Open: Horizontal Split'))
  vim.keymap.set('n', 'i', api.node.open.horizontal,            opts('Open: Horizontal Split'))
  vim.keymap.set('n', 'h', api.tree.toggle_hidden_filter,       opts('Show hidden files'))
end

return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup {
      sort = {
        sorter = "case_sensitive",
      },
      view = {
        width = 30,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = true,
      },
      hijack_directories = {
        enable = false,
        auto_open = false,
      },
      on_attach = nvim_tree_on_attach
    }
  end,
}
