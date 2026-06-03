vim.keymap.set('n', '<leader>tt', ':te<CR>i', { desc = '[T]erminal [T]ime over buffer' })
vim.keymap.set('n', '<leader>th', ':vsplit<CR>:te<CR>i', { desc = '[T]erminal to left' })
vim.keymap.set('n', '<leader>tj', ':vsplit<CR>:te<CR>i', { desc = '[T]erminal to down' })
vim.keymap.set('n', '<leader>tk', ':vsplit<CR>:te<CR>i', { desc = '[T]erminal to up' })
vim.keymap.set('n', '<leader>tl', ':vsplit<CR>:te<CR>i', { desc = '[T]erminal to right' })

vim.keymap.set('n', '<leader>tr', function()
  --Find the first terminal and re-run the last commadn
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].buftype == 'terminal' then
      local chan = vim.bo[buf].channel
      vim.api.nvim_chan_send(chan, '\27[A\r')
      return
    end
  end
  print 'No terminal buffer found'
end, { desc = '[T]erminal: Re-[R]un last command' })

vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('t', '<Esc>h', '<C-\\><C-n><C-w><C-h>', { desc = 'Exit terminal mode and go to the buffer to the left' })
vim.keymap.set('t', '<Esc>j', '<C-\\><C-n><C-w><C-j>', { desc = 'Exit terminal mode and go to the buffer to the left' })
vim.keymap.set('t', '<Esc>k', '<C-\\><C-n><C-w><C-k>', { desc = 'Exit terminal mode and go to the buffer to the left' })
vim.keymap.set('t', '<Esc>l', '<C-\\><C-n><C-w><C-l>', { desc = 'Exit terminal mode and go to the buffer to the left' })
vim.keymap.set('t', '<Esc>;', '<C-\\><C-n>:bd!<CR>y', { desc = 'Exit and close terminal' })

-- Enter terminal mode upon entering
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = { '*' },
  callback = function()
    if vim.opt.buftype:get() == 'terminal' then vim.cmd ':startinsert' end
  end,
})

--[[ Floating window terminal in this block
local terminal_state = {
	buff = nil,
	win = nil,
	is_open = false
}

local function FloatingTerminal()

	-- If terminal is already open, close it
	if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
		vim.api.nvim_win_close(terminal_state.win, false)
		terminal_state .is_open = false
		return

	end


	-- Create buffer if doesn't exist or is invalid
	if not terminal_state.buf or not vim.api.nvim_win_is_valid(terminal_state.buf) then
		terminal_state.buf = vim.api.nvim_create_buf(false, true)
		vim.bo[terminal_state.buf].bufhidden = 'hide'
	end

	-- Calaculate window dimensions
	local width = math.floor(vim.o.columns * 0.8)
	local height = math.floor(vim.o.lines * 0.8)
	local row = math.floor((vim.o.lines - height) / 2 ) 
	local col = math.floor((vim.o.columns - width) / 2)

	-- Create the floating window
	terminal_state.win = vim.api.nvim_open_win(terminal_state.buf, true, {
		relative = 'editor',
		width = width,
		height = height,
		row = row,
		col = col,
		style = 'minimal',
		border = 'rounded',
	})

	-- Transparency for floating window
	vim.wo[terminal_state.win].winblend = 0
	vim.wo[terminal_state.win].winhighlight = 'Normal:FloatingTermNormal,FloatBorder:FloatingTermBorder'

	-- Define highlight groups for transparency
	vim.api.nvim_set_hl(0, "FloatingTermNormal", { bg = "none" })
	vim.api.nvim_set_hl(0, "FloatingTermBorder", { bg = "none" })

  -- Start terminal if not already running
  local has_terminal = false
  local lines = vim.api.nvim_buf_get_lines(terminal_state.buf, 0, -1, false)
  for _, line in ipairs(lines) do
    if line ~= "" then
      has_terminal = true
      break
    end
  end

  if not has_terminal then
    vim.fn.termopen(os.getenv("SHELL"))
  end

  terminal_state.is_open =true
  vim.cmd("startinsert")

	-- Set up auto-close on buffer leave
	vim.api.nvim_create_autocmd("BufLeave", {
		callback = function()
			if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
				vim.api.nvim_win_close(terminal_state.win, false)
				terminal_state.isopen = false
			end
		end,
		once = true
	})
end

-- Function to explicitly close the terminal
local function CloseFloatingTerminal()
	if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
		vim.api.nvim_win_close(terminal_state.win, false)
		terminal_state.is_open = false
	end
end

-- Key mappings
vim.keymap.set("n", "<leader>t", FloatingTerminal, { noremap = true, silent = true, desc = 'Toggle floating terminal' })
vim.keymap.set("t", "<Esc>", function()
	if terminal_state.is_open then
		vim.api.nvim_win_close(terminal_state.win, false)
		terminal_state.is_open = false
	end
end, { noremap = true, silent = true, desc = "Close floating terminal from terminal mode" })

--]]
-- vim: ts=2 sts=2 sw=2 et
