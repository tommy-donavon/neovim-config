local lazy = require('core.lazy')

lazy.add_plugin('nvimdev/dashboard-nvim', {
  event = 'VimEnter',
  config = function()
    require('ui.config.dashboard')
  end,
})

lazy.add_plugin('catppuccin/nvim', {
  priority = 1000,
})
