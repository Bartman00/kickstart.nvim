return { -- Collection of various small independent plugins/modules
  --  Check out: https://github.com/nvim-mini/mini.nvim
  'nvim-mini/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    -- You have to go FAST! s is substitute by default in nvim
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup()

    -- Improves pair handling
    require('mini.pairs').setup {}

    -- Simple and easy statusline.
    --  You could remove this setup call if you don't like it,
    --  and try some other statusline plugin
    local statusline = require 'mini.statusline'
    -- set use_icons to true if you have a Nerd Font
    statusline.setup { use_icons = vim.g.have_nerd_font }

    -- You can configure sections in the statusline by overriding their
    -- default behavior. For example, here we set the section for
    -- cursor location to LINE:COLUMN
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function() return '%2l:%-2v' end

    -- Mode colors
    vim.api.nvim_set_hl(0, 'MiniStatuslineModeNormal', { fg = '#000000', bg = '#00FF00', bold = true })
    vim.api.nvim_set_hl(0, 'MiniStatuslineModeInsert', { fg = '#000000', bg = '#FF0000', bold = true })
    vim.api.nvim_set_hl(0, 'MiniStatuslineModeVisual', { fg = '#000000', bg = '#00FFFF', bold = true })
    vim.api.nvim_set_hl(0, 'MiniStatuslineModeReplace', { fg = '#000000', bg = '#FF00FF', bold = true })
    vim.api.nvim_set_hl(0, 'MiniStatuslineModeCommand', { fg = '#000000', bg = '#FFFF00', bold = true })
    vim.api.nvim_set_hl(0, 'MiniStatuslineModeOther', { fg = '#FFFFFF', bg = '#0000FF', bold = true })
    -- ... and there is more!

    -- Files
    require('mini.files').setup {
      close_on_file = true,
    }
    vim.keymap.set('n', '<leader>nm', ':lua MiniFiles.open()<CR>', { desc = 'Mini explorer' })
  end,
}

-- Command colors

-- vim: ts=2 sts=2 sw=2 et
