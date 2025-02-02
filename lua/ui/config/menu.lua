-- Keyboard users
vim.keymap.set('n', '<C-t>', function()
  require('menu').open('default')
end, {})

vim.keymap.set({ 'n', 'v' }, '<RightMouse>', function()
  require('menu.utils').delete_old_menus()

  vim.cmd.exec('"normal! \\<RightMouse>"')

  local buf = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)
  local options = vim.bo[buf].ft == 'NvimTree' and 'nvimtree' or 'default'

  require('menu').open(options, { mouse = true })
end, {})
