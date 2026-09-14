return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "rcarriga/nvim-dap-ui",
  },
  config = function ()
    local dap = require('dap')
    require("dapui").setup()
    dap.adapters.gdb = {
      type = "executable",
      command = "gdb",
      args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
    }
    vim.keymap.set('n', '<Leader>db', function() dap.toggle_breakpoint() end)
    vim.keymap.set('n', '<Leader>dc', function() dap.continue() end)
  end
}
