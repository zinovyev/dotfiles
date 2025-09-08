local on_attach = function(client, bufnr)
  local opts = { buffer = bufnr, noremap = true, silent = true }

  -- When on a symbol, go to the file that defines it
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)

  -- When on a symbol, open up a split showing files referencing 
  -- this symbol. You can hit enter on any file and that file
  -- and location of the reference open.
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

  -- Open up a split and show all symbols defined in the current
  -- file. Hitting enter on any symbol jumps to that location
  -- in the file
  vim.keymap.set('n', 'gs', vim.lsp.buf.document_symbol, opts)

  -- Open a popup window showing any help available for the 
  -- method signature you are on
  vim.keymap.set('n', 'gK', vim.lsp.buf.signature_help, opts)

  -- If there are errors or warnings, go to the next one
  vim.keymap.set('n', 'dn', function() vim.diagnostic.jump({ count = 1, float = true }) end)

  -- If there are errors or warnings, go to the previous one
  vim.keymap.set('n', 'dp', function() vim.diagnostic.jump({ count = -1, float = true }) end)

  -- If you are on a line with an error or warning, open a 
  -- popup showing the error/warning message
  vim.keymap.set('n', 'do', vim.diagnostic.open_float)

  -- Open the "hover" window on a symbol, which tends to show
  -- documentation on that symbol inline
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)

  -- While in insert mode, Ctrl-Space will invoke Ctrl-X Ctrl-o 
  -- which initiates completion to show a list of symbols that
  -- make sense for autocomplete
  vim.api.nvim_set_keymap('i', '<C-Space>', '<C-x><C-o>', { noremap = true, silent = true })

  -- Enable "inlay hints"
  vim.lsp.inlay_hint.enable()

  -- Enable completion
  vim.lsp.completion.enable(true, client.id, bufnr, {
    autotrigger = true, -- automatically pop up when e.g.  you type '.' after a variable
    convert = function(item)
      return { abbr = item.label:gsub('%b()', '') } -- NGL, no clue what this is for but it's needed
    end,
  })

  -- If the LSP server supports semantic tokens to be used for highlighting
  -- enable that.
  if client and client.server_capabilities.semanticTokensProvider then
    vim.lsp.semantic_tokens.start(args.buf,args.data.client_id)
  end
end

-- The documentation said to set this for completion
-- to work properly and/or well. I'm not sure what happens
-- if you omit this
vim.cmd[[set completeopt+=menuone,noselect,popup]]

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "mason-org/mason.nvim", opts = {} }
  },
  on_attach = on_attach
}
