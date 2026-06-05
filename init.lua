-- See ./doc folder for introduction

-- Set <space> as the leader key

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true


require 'options'
require 'keymaps'
require 'diagnostic'
require 'autocmd'
require 'terminal'
require 'lazy-bootstrap'
require 'lazy-plugins'
-- require 'debug'

--[[
Links & Notes:

Great liteweight config which doesn't rely on plugins for everything
https://github.com/radleylewis/nvim-lite/blob/master/init.lua

OG
https://github.com/nvim-lua/kickstart.nvim

The OG is a monolith. This breaks up kickstart into more manageable files
https://github.com/dam9000/kickstart-modular.nvim

TODO:
(DONE) Remove theme as a plugin.
(DONE) Get command bar mode colors to match cursor
(DONE) Get file tree working
(DONE) Get mini.files working
(DONE) Lookup mini.files config video. Want to close when I select a file.
(DONE) Use nvim-lite terminal options Add multiline add function
(DONE) Variable o/O behavior)

--]]

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
