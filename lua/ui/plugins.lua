local lazy = require('core.lazy')

lazy.add_plugin('nvimdev/dashboard-nvim', {
  event = 'VimEnter',
  config = function()
    require('ui.config.dashboard')
  end,
})

lazy.add_plugin('nvim-lualine/lualine.nvim', {
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('ui.config.lualine')
  end,
})

lazy.add_plugin('sphamba/smear-cursor.nvim', {
  config = function()
    require('ui.config.smear')
  end,
})

lazy.add_plugin('charm-and-friends/freeze.nvim', {
  config = function()
    require('ui.config.freeze')
  end,
})

lazy.add_plugin('catppuccin/nvim', {
  priority = 1000,
})
