--- ============================
--- General settings
--- ============================
local opt = vim.opt
opt.encoding = "UTF-8"              -- Proper encoding
opt.number = true                   -- Enable line numbers
opt.relativenumber = false          -- Enable line numbers
opt.cursorline = true               -- Highlight current line
opt.scrolloff = 10                  -- Keep cursor 10 chars before the border
opt.sidescrolloff = 8               -- Keep cursor 10 chars before the border when sliding horizontally
opt.wrap = false                    -- Don't wrap lines
opt.cmdheight = 1                   -- Command window height 
opt.confirm = true
opt.autochdir = false               -- Don't change directory automatically
opt.clipboard:append("unnamedplus") -- Append system clipboard
opt.mouse = "a"
opt.modifiable = true               -- Make all buffers editable
opt.wildmenu = true                 -- Enable wildmenu
opt.wildmode = 'longest:full,full'  -- Wildmenu completion mode
opt.wildignorecase = true           -- Completion ignores the case

-- Visual settings
opt.termguicolors = true  -- Enable 24-bit colors
opt.signcolumn = 'yes'    -- Always show sign column (for git signs and diagnostics)
opt.colorcolumn = '100'   -- Show column at 100 chars
opt.synmaxcol = 300       -- Syntax highlighting column limit
opt.showmode = false      -- Show current VIM mode
opt.pumheight = 10        -- Popup menu height
opt.pumblend = 10         -- Popup menu transparency
opt.winblend = 10         -- Floating window transparency
opt.conceallevel = 0      -- Don't hide markup
opt.concealcursor = ''    -- Don't hide markup even on cursor line
opt.lazyredraw = false    -- While executing a macros
opt.redrawtime = 10000    -- Timeout for syntax highlighting
opt.maxmempattern = 20000 -- Max memory for pattern matching

-- Configure whitespaces/tabs
opt.tabstop = 2        -- Tab width
opt.shiftwidth = 2     -- Indent width
opt.softtabstop = 2    -- Soft width. Make the tab press equal to the tab size (tabstop)
opt.autoindent = true  -- Copy indent from current line
opt.smartindent = true -- Smart auto-indenting
opt.expandtab = true   -- Convert tabs to spaces

-- More intuitive window-splitting behavior
opt.splitbelow = true
opt.splitright = true

-- Search settings
opt.ignorecase = true -- Ignore case in search
opt.smartcase = true  -- Unignore case if case contains an uppercase letter
opt.hlsearch = true   -- Highlight search
opt.incsearch = true  -- Show matches as you type
opt.showmatch = true  -- Hl matching brackets
opt.matchtime = 2     -- How long to show matching bracket

-- Get rid of swap and all the junk
opt.backup = false      -- Don't create backup files
opt.swapfile = false    -- Don't create swap files
opt.writebackup = false -- Don't create backup file before overwriting
opt.undofile = false    -- Don't create undo file
opt.updatetime = 250    -- Time in ms to trigger CursorHold
opt.autoread = true     -- Autoreload file if changed from outside
