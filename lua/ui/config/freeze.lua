require('freeze').setup {
  command = 'freeze',
  open = true,
  output = function()
    ---@diagnostic disable-next-line: param-type-mismatch
    return './screenshots/' .. os.date('%format') .. '_freeze.png'
  end,
  theme = 'catppuccin-mocha',
}

vim.api.nvim_set_keymap('v', '<leader>sc', '<cmd>Freeze<cr>', { desc = '[s]creen [c]apture' })
vim.api.nvim_set_keymap('n', '<leader>so', '<cmd>Freeze open<cr>', { desc = '[s]creen capture [o]pen' })
