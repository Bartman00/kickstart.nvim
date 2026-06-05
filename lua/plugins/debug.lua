--[[
<F4> — dap.terminate()
<F5> — dap.continue() 
<F6> — dap.pause() 
<F7> — step_over()
<F8> — step_into()
<F9> — step_out()
<F10> — dapui.toggle() manually shows/hides the UI panels (useful if they get closed or you want to hide them)
<leader>db — toggle_breakpoint() sets or removes a breakpoint on the current line
<leader>dB — set_breakpoint() with an input prompt lets you set a conditional breakpoint, e.g. x > 5, so it only pauses when the condition is true
--]]
return {
	
  'mfussenegger/nvim-dap',
  dependencies = {
    -- DAP UI
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio', -- required by dap-ui

    -- Mason integration for auto-installing adapters
    -- NOTE: Mason is required in the lsp configuration
    'jay-babu/mason-nvim-dap.nvim',

    -- Python-specific
    'mfussenegger/nvim-dap-python',
  },

  keys = {
    { '<F4>',       function() require('dap').terminate() end,          desc = 'Debug: Terminate' },
    { '<F5>',       function() require('dap').continue() end,          desc = 'Debug: Start/Continue' },
    { '<F6>',       function() require('dap').pause() end,              desc= 'Debug: Pause '},
    { '<F7>',      function() require('dap').step_over() end,         desc = 'Debug: Step Over' },
    { '<F8>',      function() require('dap').step_into() end,         desc = 'Debug: Step Into' },
    { '<F9>',      function() require('dap').step_out() end,          desc = 'Debug: Step Out' },
    { '<F10>',       function() require('dapui').toggle() end, desc = 'Debug: Toggle UI' },
    { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'Debug: Toggle Breakpoint' },
    {
      '<leader>dB',
      function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end,
      desc = 'Debug: Set Conditional Breakpoint',
    },
    { '<leader>du', function() require('dapui').toggle() end, desc = 'Degug: Toggle UI'},
  },

  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    -- Auto-install debugpy via Mason
    require('mason-nvim-dap').setup {
      automatic_installation = true,
      handlers = {},
      ensure_installed = { 'debugpy' },
    }

    -- Point nvim-dap-python at the debugpy Mason installs
    require('dap-python').setup(
      vim.fn.stdpath 'data' .. '/mason/packages/debugpy/venv/bin/python'
    )

    -- DAP UI setup
    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸', play = '▶', step_into = '⏎', step_over = '⏭',
          step_out = '⏮', step_back = 'b', run_last = '▶▶',
          terminate = '⏹', disconnect = '⏏',
        },
      },
    }

    -- Auto open/close UI with debug session
    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close
  end,
}
