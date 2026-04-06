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

local function find_and_replace(find, replace)
  local rg_cmd = string.format("rg --files-with-matches --no-messages %s", vim.fn.shellescape(find))
  local files = vim.fn.systemlist(rg_cmd)

  if #files == 0 then
    vim.api.nvim_echo({{"No matches found for '" .. find .. "'", "WarningMsg"}}, false, {})
    return 0
  end

  local changed = 0
  for _, file in ipairs(files) do
    local bufnr = vim.fn.bufadd(file)
    vim.fn.bufload(bufnr)

    vim.api.nvim_buf_call(bufnr, function()
      vim.cmd(string.format("%%s/%s/%s/g", vim.fn.escape(find, "/\\"), vim.fn.escape(replace, "/\\")))
    end)

    if vim.api.nvim_buf_get_option(bufnr, "modified") then
      vim.api.nvim_buf_call(bufnr, function() vim.cmd("w") end)
      changed = changed + 1
    end
  end

  vim.api.nvim_echo({{"Replaced '" .. find .. "' with '" .. replace .. "' in " .. changed .. " files.", "Normal"}}, false, {})
  return changed
end

vim.api.nvim_create_user_command('FindAndReplace', function(opts)
  local args = {}
  for word in opts.args:gmatch("%S+") do table.insert(args, word) end
  if #args < 2 then
    vim.api.nvim_echo({{"Usage: :FindAndReplace <find> <replace>", "WarningMsg"}}, false, {})
    return
  end

  find_and_replace(args[1], args[2])
end, {
  nargs = "+",
  desc = "Find and Replace in all project files"
})

vim.api.nvim_create_user_command('FindAndRefactor', function(opts)
  local args = {}
  for word in opts.args:gmatch("%S+") do table.insert(args, word) end
  if #args < 2 then
    vim.api.nvim_echo({{"Usage: :FindAndRefactor <find> <replace>", "WarningMsg"}}, false, {})
    return
  end

  local find, replace = args[1], args[2]

  -- 1️⃣ Replace inside files
  local changed = find_and_replace(find, replace)

  -- 2️⃣ Rename files
  local file_cmd = string.format("rg --files --no-messages -g '*%s*'", vim.fn.shellescape(find))
  local files_to_rename = vim.fn.systemlist(file_cmd)

  local renamed_files = 0
  for _, old_path in ipairs(files_to_rename) do
    local new_path = old_path:gsub(find, replace)
    if new_path ~= old_path then
      vim.fn.mkdir(vim.fn.fnamemodify(new_path, ":h"), "p")
      os.rename(old_path, new_path)
      renamed_files = renamed_files + 1
    end
  end

  -- 3️⃣ Rename directories (bottom-up to avoid path conflicts)
  local dir_cmd = string.format("find . -type d -name '*%s*'", find)
  local dirs_to_rename = vim.fn.systemlist(dir_cmd)

  -- Sort by descending path length to rename deepest directories first
  table.sort(dirs_to_rename, function(a, b)
    return #a > #b
  end)

  local renamed_dirs = 0
  for _, old_dir in ipairs(dirs_to_rename) do
    local new_dir = old_dir:gsub(find, replace)
    if new_dir ~= old_dir then
      os.rename(old_dir, new_dir)
      renamed_dirs = renamed_dirs + 1
    end
  end

  vim.api.nvim_echo({{
    string.format(
      "Refactored '%s' → '%s': %d files updated, %d files renamed, %d directories renamed.",
      find, replace, changed, renamed_files, renamed_dirs
    ),
    "Normal"
  }}, false, {})
end, {
  nargs = "+",
  desc = "Find, Replace, and Rename files/directories containing the pattern"
})
