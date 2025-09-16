-- Open For Directories And Change Neovim's Directory
-- local function open_nvim_tree(data)
--   -- buffer is a directory
--   local directory = vim.fn.isdirectory(data.file) == 1
-- 
--   if not directory then
--     return
--   end
-- 
--   -- create a new, empty buffer
--   vim.cmd.enew()
-- 
--   -- wipe the directory buffer
--   vim.cmd.bw(data.buf)
-- 
--   -- change to the directory
--   vim.cmd.cd(data.file)
-- 
--   -- open the tree
--   require("nvim-tree.api").tree.open()
-- end
-- vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })


vim.api.nvim_create_user_command('Gblame', function()
    local keys = vim.api.nvim_replace_termcodes(":Gitsigns blame <CR><CR>",true,false,true)
    vim.api.nvim_feedkeys(keys, 'm', false)
  end,
  {nargs = 0, desc = 'Show Git Blame sidebar'}
)

vim.api.nvim_create_user_command('Format', function()
    if vim.lsp then
      vim.lsp.buf.format()
    else
      vim.echon("LSP not loaded yet")
    end
  end,
  {nargs = 0, desc = 'Show Git Blame sidebar'}
)
