-- Appearance
-- Status bar colors are defined in the mini plugin
vim.cmd.colorscheme("industry") -- Theme
vim.api.nvim_set_hl(0, 'Keyword', { fg = '#FFFF00'})


-- Cursor colors
vim.opt.termguicolors = true
vim.api.nvim_set_hl(0, "CursorNormal", { fg = "black", bg = "#00FF00" })
vim.api.nvim_set_hl(0, "CursorInsert", { fg = "black", bg = "#FF0000" }) 
vim.api.nvim_set_hl(0, "CursorVisual", { fg = "black", bg = "#00FFFF" })
vim.api.nvim_set_hl(0, "CursorReplace", { fg = "black", bg = "#FF00FF" })
vim.api.nvim_set_hl(0, "Comment", { fg = '#0080ff' })
-- vim.api.nvim_set_hl(0, "Statusline", { fg='black', bg="#FF0000" })
-- vim.api.nvim_set_hl(0, "CursorLine", { bg = "#004400" })
-- vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "#00FF00" })

-- Color the cursor line based on the mode.
vim.api.nvim_create_autocmd('ModeChanged', {
  pattern = "*:*",
  callback =  function()
    local new_mode = vim.api.nvim_get_mode().mode
    if new_mode == 'n' then
      vim.api.nvim_set_hl(0, "CursorLine", { bg = '#004400' })
    elseif new_mode == 'v' then
      vim.api.nvim_set_hl(0, "CursorLine", { bg = '#004444' })
    elseif new_mode:match("[V\x16]")  then
      vim.api.nvim_set_hl(0, "CursorLine", { bg = '#00FFFF' })
    elseif new_mode == 'i' then
      vim.api.nvim_set_hl(0, "CursorLine", { bg = '#440000' })
    elseif new_mode == 'c' then
      vim.api.nvim_set_hl(0, "CursorLine", { bg = '#444400' })
    elseif new_mode == 'R' then
      vim.api.nvim_set_hl(0, "CursorLine", { bg = '#660066' })
    end
  end,
})

vim.opt.guicursor = {
  -- Normal & Command: Green Block + Blinking
  "n-c:block-CursorNormal-blinkwait700-blinkoff400-blinkon250",
  -- Insert: Red Block + Blinking
  "i-ci:block-CursorInsert-blinkwait700-blinkoff400-blinkon250",
  -- Visual: Blue Block + Blinking
  "v-ve:block-CursorVisual-blinkwait700-blinkoff400-blinkon250",
  -- Other modes (Replace, etc.)
  "r-cr:block-CursorReplace-blinkwait700-blinkoff400-blinkon400"
}

vim.o.number = true -- Make line numbers default
vim.o.relativenumber = true -- Relative line numbers
vim.o.mouse = 'a' -- Enable mouse mode
vim.o.showmode = false -- Still not sure what this does.
vim.o.breakindent = true -- Horizontally wrapped keeps indend from first line.
vim.o.undofile = true -- Save undo history
vim.o.signcolumn = 'yes' -- Keep column of symbols left of numbers on
vim.o.updatetime = 250 -- Decrease update time for background tasks
vim.o.timeoutlen = 300 -- Decrease mapped sequence wait time
vim.o.inccommand = 'split' -- Preview substitutions live, as you type!
vim.o.cursorline = true -- Show which line your cursor is on
vim.o.scrolloff = 10 -- Number of screen lines to keep above/below cursor.
vim.o.confirm = true -- Confirm before quitting if have unsaved changes

-- Use system clipboard
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

-- Visual
vim.opt.showmatch = true

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true

-- How new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Whitespace characters
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Command-line completion
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wildignore:append({ "*.o", "*.obj", "*.pyc", "*.class", "*.jar" })

-- Remove auto-comment
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- File handling
vim.opt.swapfile = false                           -- Don't create swap files
vim.opt.undofile = true                            -- Persistent undo

-- Center screen when jumping
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- vim: ts=2 sts=2 sw=2 et
