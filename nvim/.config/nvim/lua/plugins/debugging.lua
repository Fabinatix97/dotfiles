return {
  'mfussenegger/nvim-dap',

  dependencies = {
    -- Mason
    {
      'mason-org/mason.nvim',
      config = function()
        require('mason').setup()
      end,
    },

    -- Mason DAP integration
    {
      'jay-babu/mason-nvim-dap.nvim',
      dependencies = {
        'mfussenegger/nvim-dap',
      },
      config = function()
        require('mason-nvim-dap').setup {
          automatic_installation = true,

          ensure_installed = {
            'php',
          },

          handlers = {},
        }
      end,
    },

    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',
  },

  keys = {
    { '<F5>', function() require('dap').continue() end, desc = 'debug: start/continue' },
    { '<F1>', function() require('dap').step_into() end, desc = 'debug: step into' },
    { '<F2>', function() require('dap').step_over() end, desc = 'debug: step over' },
    { '<F3>', function() require('dap').step_out() end, desc = 'debug: step out' },

    { '<leader>b', function() require('dap').toggle_breakpoint() end, desc = 'debug: toggle breakpoint' },

    {
      '<leader>B',
      function()
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      desc = 'debug: set breakpoint',
    },

    { '<F7>', function() require('dapui').toggle() end, desc = 'debug: toggle DAP UI' },
  },

  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    -- DAP UI setup
    ---@diagnostic disable-next-line: missing-fields
    dapui.setup {
      icons = {
        expanded = '▾',
        collapsed = '▸',
        current_frame = '*',
      },

      ---@diagnostic disable-next-line: missing-fields
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    -- Automatically open/close DAP UI
    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open()
    end

    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close()
    end

    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close()
    end

    -- Breakpoint icons
    -- vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
    -- vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })

    -- local breakpoint_icons = vim.g.have_nerd_font
    --     and {
    --       Breakpoint = '',
    --       BreakpointCondition = '',
    --       BreakpointRejected = '',
    --       LogPoint = '',
    --       Stopped = '',
    --     }
    --   or {
    --       Breakpoint = '●',
    --       BreakpointCondition = '⊜',
    --       BreakpointRejected = '⊘',
    --       LogPoint = '◆',
    --       Stopped = '⭔',
    --     }

    -- for type, icon in pairs(breakpoint_icons) do
    --   local tp = 'Dap' .. type
    --   local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
    --   vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    -- end

  end,
}
