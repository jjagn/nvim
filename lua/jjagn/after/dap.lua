local dap = require("dap")
dap.adapters.gdb = {
  type = "executable",
  command = "gdb",
  args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
}

dap.configurations.c = {
  {
    name = "Launch",
    type = "gdb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = "${workspaceFolder}",
    stopAtBeginningOfMainSubprogram = false,
  },
  {
    name = "Select and attach to process",
    type = "gdb",
    request = "attach",
    program = function()
       return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    pid = function()
       local name = vim.fn.input('Executable name (filter): ')
       return require("dap.utils").pick_process({ filter = name })
    end,
    cwd = '${workspaceFolder}'
  },
  {
    name = 'Attach to gdbserver :2331 (JLink)',
    type = 'gdb',
    request = 'attach',
    target = 'localhost:2331',
    program = function()
       return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}'
  },
}


vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = "Add breakpoint" })
vim.keymap.set('n', '<leader>dc', dap.continue, { desc = "Continue" })
vim.keymap.set('n', '<leader>do', dap.step_over, { desc = "Step over" })
vim.keymap.set('n', '<leader>di', dap.step_into, { desc = "Step into" })
vim.keymap.set('n', '<leader>dl', dap.launch, { desc = "Launch debugge" })
