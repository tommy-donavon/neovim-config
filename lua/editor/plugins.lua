local lazy = require('core.lazy')

lazy.add_plugin('lewis6991/impatient.nvim')

lazy.add_plugin('nvim-lua/plenary.nvim', { lazy = true })

lazy.add_plugin('antoinemadec/FixCursorHold.nvim', { event = 'VimEnter' })

lazy.add_plugin('saghen/blink.cmp', {
  dependencies = { 'rafamadriz/friendly-snippets' },
  version = '*',
  config = function()
    require('editor.config.blink')
  end,
  opts_extend = { 'sources.default' },
})

lazy.add_plugin('folke/snacks.nvim', {
  lazy = false,
  config = function()
    require('editor.config.snacks')
  end,
})

lazy.add_plugin('rcarriga/nvim-notify', {
  event = 'BufRead',
  config = function()
    vim.notify = require('notify')
  end,
})

lazy.add_plugin('ahmedkhalf/project.nvim', {
  config = function()
    require('editor.config.project')
  end,
})

lazy.add_plugin('aznhe21/actions-preview.nvim', {
  config = function()
    require('editor.config.actions-preview')
  end,
})

lazy.add_plugin('Bilal2453/luvit-meta', { lazy = true })

lazy.add_plugin('neovim/nvim-lspconfig', {
  lazy = true,
  dependencies = {
    { 'simrat39/inlay-hints.nvim', lazy = true },
    { 'nvimtools/none-ls.nvim', lazy = true, event = { 'BufReadPost', 'BufNewFile' } },
  },
  event = { 'BufReadPost', 'BufNewFile', 'BufWinEnter' },
  config = function()
    require('editor.config.lsp')
  end,
})

lazy.add_plugin('windwp/nvim-autopairs', {
  event = 'InsertEnter',
  config = true,
})

lazy.add_plugin('folke/which-key.nvim', {

  event = 'VimEnter',
  opts = {
    icons = {
      mappings = true,
      keys = {},
    },
    spec = {
      { '<leader>c', group = '[c]ode', mode = { 'n', 'x' } },
      { '<leader>d', group = '[d]ocument' },
      { '<leader>r', group = '[r]ename' },
      { '<leader>s', group = '[s]earch' },
      { '<leader>w', group = '[w]orkspace' },
      { '<leader>t', group = '[t]oggle' },
      { '<leader>g', group = '[g]it', mode = { 'n', 'v' } },
    },
  },
})

lazy.add_plugin('nvim-treesitter/nvim-treesitter', {
  build = function()
    if #vim.api.nvim_list_uis() ~= 0 then
      vim.cmd('TSUpdate')
    end
  end,
  config = function()
    require('editor.config.treesitter')
  end,
  event = { 'BufRead', 'BufNewFile' },
})

lazy.add_plugin('nvim-treesitter/playground', {
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  event = 'BufRead',
})

lazy.add_plugin('nvim-treesitter/nvim-treesitter-textobjects', {
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  event = 'BufRead',
})

lazy.add_plugin('RRethy/nvim-treesitter-textsubjects', {
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  event = 'BufRead',
})

lazy.add_plugin('JoosepAlviste/nvim-ts-context-commentstring', {
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  event = 'BufRead',
})

lazy.add_plugin('windwp/nvim-ts-autotag', {
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  event = 'BufRead',
})

lazy.add_plugin('stevearc/conform.nvim', {
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  branch = 'nvim-0.9',
  config = function()
    require('editor.config.conform')
  end,
})

lazy.add_plugin('lewis6991/hover.nvim', {
  config = function()
    require('editor.config.hover')
  end,
})

lazy.add_plugin('mfussenegger/nvim-lint', {
  config = function()
    require('editor.config.lint')
  end,
})

lazy.add_plugin('lewis6991/gitsigns.nvim', {
  config = function()
    require('editor.config.gitsigns')
  end,
})

lazy.add_plugin('mrcjkb/rustaceanvim', {
  version = '^5',
  lazy = false,
  config = function()
    require('editor.config.rust')
  end,
})

lazy.add_plugin('ray-x/go.nvim', {
  dependencies = {
    'ray-x/guihua.lua',
    'neovim/nvim-lspconfig',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('editor.config.go')
  end,
  event = { 'CmdlineEnter' },
  ft = { 'go', 'gomod' },
  build = ':lua require("go.install").update_all_sync()',
})

lazy.add_plugin('iamcco/markdown-preview.nvim', {
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  ft = { 'markdown' },
  build = function()
    vim.fn['mkdp#util#install']()
  end,
})
