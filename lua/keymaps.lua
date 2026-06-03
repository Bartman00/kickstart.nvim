-- Non-plugin keymaps. Plugins such as mini and which-key have additional

----------------- NORMAL MODE SHORTCUTS ---------------------
-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Return to normal mode
vim.keymap.set('i', 'jk', '<ESC>', { noremap = true, silent = true, desc = 'Escape using jk' })

-- Diagonostic Keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Window navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Goto definition
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to Definition' })


-- More convenient beginning / end of line.
vim.keymap.set('n', '<leader>h', "^", { desc = 'beginning of line'})
vim.keymap.set('n', '<leader>l', "$", { desc = 'end of line'})

----------------- Common Shortcuts in other Programs to reuse --------------------
-- Copy entire buffer to system clipboard
vim.keymap.set('n', '<leader>c', ":%y+<CR>", { desc = '[C]opy entire buffer to clipboard'})

-- Save
vim.keymap.set('n', '<C-s>', ':w<CR>', { desc = 'Save'})

----------------- Splitting & resizing ---------------------
vim.keymap.set('n', '<leader>bv', ':vsplit<CR>', { desc = 'Split window vertically' })
vim.keymap.set('n', '<leader>bh', ':split<CR>', { desc = 'Split window horizontally' })
vim.keymap.set('n', '<C-Up>', ':resize +2<CR>', { desc = 'Increase window height' })
vim.keymap.set('n', '<C-Down>', ':resize -2<CR>', { desc = 'Decrease window height' })
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', { desc = 'Decrease window width' })
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', { desc = 'Increase window width' })

----- BUFFER SHORTCUTS -----
-- Toggle between last
vim.keymap.set('n', '<leader><leader>', '<c-^>', { desc = 'Switch to last buffer' })
-- Next buffer
vim.keymap.set('n', '<leader>bn', ':bnext<CR>', { desc = 'Next buffer' })
-- Previous buffer
vim.keymap.set('n', '<leader>bp', ':bprevious<CR>', { desc = 'Previous buffer' })
-- Delete the current buffer
vim.keymap.set('n', '<leader>bd', ':bdelete<CR>', { desc = 'Delete buffer' })

----------------- TERMINAL MODE SHORTCUTS ---------------------
-- Exit the terminal
-- vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

----------------- Config Files ---------------------
vim.keymap.set('n', '<leader>rc', ':e $MYVIMRC<CR>', { desc = 'Edit config' })

-- Move lines up/down
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', { desc = 'Move line down' })
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', { desc = 'Move line up' })
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

-- Better indenting in visual mode
vim.keymap.set('v', '<', '<gv', { desc = 'Indent left and reselect' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right and reselect' })

------------------------- File explorer --------------------
vim.keymap.set('n', '<leader>ne', ':Explore<CR>', { desc = 'Default Explorer' })
-- mini.files and neo-tree shortcuts are in their plugin files

------------------------- Variable insert lines for o and O --------------------
-- SmartCountLines Module
local SmartOpen = {}

function SmartOpen.open_lines(direction)
  local count = vim.v.count1
  local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
  local line_content = vim.api.nvim_get_current_line()

  -- 1. Determine base indentation
  local indent_size = vim.fn.indent(row)

  -- 2. Apply smart indent for block starters (Python ':', Lua '{', etc.)
  -- Only applies when opening 'below' a block starter
  if direction == 'below' and line_content:match '[:{[(]%s*$' then indent_size = indent_size + vim.bo.shiftwidth end

  -- 3. Construct the indentation string
  local char = vim.bo.expandtab and ' ' or '\t'
  local amount = vim.bo.expandtab and indent_size or math.floor(indent_size / vim.bo.tabstop)
  local indent_str = string.rep(char, amount)

  -- 4. Create line table
  local lines = {}
  for _ = 1, count do
    table.insert(lines, indent_str)
  end

  -- 5. Insert lines and position cursor
  if direction == 'below' then
    vim.api.nvim_buf_set_lines(0, row, row, false, lines)
    vim.api.nvim_win_set_cursor(0, { row + 1, #indent_str })
  else
    vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, lines)
    vim.api.nvim_win_set_cursor(0, { row, #indent_str })
  end

  -- 6. Go into insert mode
  vim.cmd 'startinsert!'
end

-- Keybindings
vim.keymap.set('n', 'o', function() SmartOpen.open_lines 'below' end, { desc = 'Smart o with count' })
vim.keymap.set('n', 'O', function() SmartOpen.open_lines 'above' end, { desc = 'Smart O with count' })

-- vim: ts=2 sts=2 sw=2 et
