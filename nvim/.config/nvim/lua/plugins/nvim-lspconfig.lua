-- The documentation said to set this for completion
-- to work properly and/or well. I'm not sure what happens
-- if you omit this
vim.cmd[[set completeopt+=menuone,noselect,popup]]

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "mason-org/mason.nvim", opts = {} }
  },
  config = function()
    -- Ruby LSP
    vim.lsp.config('ruby_lsp', {
      init_options = {
        formatter = 'rubocop',
        linters = { 'standard' },
      },
    })
    vim.lsp.enable('ruby_lsp')

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
    vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Find references" })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show hover docs" })
  end
}
