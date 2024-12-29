local lazy = require('core.lazy')

lazy.add_plugin('lewis6991/impatient.nvim')

lazy.add_plugin('nvim-lua/plenary.nvim', { lazy = true })

lazy.add_plugin('antoinemadec/FixCursorHold.nvim', { event = 'VimEnter' })

lazy.add_plugin('rcarriga/nvim-notify', {
  event = 'BufRead',
})

lazy.add_plugin('ahmedkhalf/project.nvim', {
  config = function()
    require('editor.config.project')
  end,
})

lazy.add_plugin('nvim-telescope/telescope.nvim', {
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',

      build = 'make',

      cond = function()
        return vim.fn.executable('make') == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons' },
  },

  config = function()
    require('editor.config.telescope')
  end,
})

lazy.add_plugin('aznhe21/actions-preview.nvim', {
  config = function()
    require('editor.config.actions-preview')
  end,
})

lazy.add_plugin('nvim-telescope/telescope-file-browser.nvim', {
  dependencies = { 'nvim-telescope/telescope.nvim' },
})

lazy.add_plugin('Bilal2453/luvit-meta', { lazy = true })

lazy.add_plugin('williamboman/mason.nvim', {
  dependencies = {
    { 'williamboman/mason-lspconfig.nvim', lazy = true },
    { 'neovim/nvim-lspconfig', lazy = true },
    { 'hrsh7th/cmp-nvim-lsp', lazy = true, dependencies = { 'hrsh7th/nvim-cmp' } },
    { 'nvimtools/none-ls.nvim', lazy = true, event = { 'BufReadPost', 'BufNewFile' } },
    { 'jay-babu/mason-null-ls.nvim', lazy = true },
    { 'simrat39/inlay-hints.nvim', lazy = true },
  },
  config = function()
    require('editor.config.mason')
  end,
})

lazy.add_plugin('hrsh7th/nvim-cmp', {
  event = 'InsertEnter',
  dependencies = {
    {
      'L3MON4D3/LuaSnip',
      build = 'make install_jsregexp',
      lazy = false,
      version = "v2.3.0",
      cond = function()
        return vim.fn.executable('make') == 1
      end,
    },
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    {
      'windwp/nvim-autopairs',
      branch = 'master',
      config = function()
        local autopairs = require('nvim-autopairs')
        autopairs.setup({
          disable_filetype = { 'TelescopePrompt', 'vim' },
        })
      end,
      lazy = true,
    },
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-vsnip',
    'hrsh7th/nvim-cmp',
    'hrsh7th/vim-vsnip',
  },
  config = function()
    require('editor.config.cmp')
  end,
})

lazy.add_plugin('hrsh7th/cmp-nvim-lua', { dependencies = { 'hrsh7th/nvim-cmp' }, event = 'BufRead' })
lazy.add_plugin('hrsh7th/cmp-buffer', { dependencies = { 'hrsh7th/nvim-cmp' }, event = 'BufRead' })
lazy.add_plugin('hrsh7th/cmp-path', { dependencies = { 'hrsh7th/nvim-cmp' }, event = 'BufRead' })
lazy.add_plugin('hrsh7th/cmp-cmdline', { dependencies = { 'hrsh7th/nvim-cmp' }, event = 'BufRead' })
lazy.add_plugin('dmitmel/cmp-cmdline-history', { dependencies = { 'hrsh7th/nvim-cmp' }, event = 'BufRead' })

lazy.add_plugin('folke/which-key.nvim', {

  event = 'VimEnter',
  opts = {
    icons = {
      mappings = true,
      keys = {},
    },
    spec = {
      { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
      { '<leader>d', group = '[D]ocument' },
      { '<leader>r', group = '[R]ename' },
      { '<leader>s', group = '[S]earch' },
      { '<leader>w', group = '[W]orkspace' },
      { '<leader>t', group = '[T]oggle' },
      { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
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

lazy.add_plugin('is0n/fm-nvim', {
  config = function()
    vim.keymap.set('n', '<leader>tf', ':Xplr<CR>', { desc = '[T]oggle [F]ile explorer' })
  end,
})

lazy.add_plugin('folke/zen-mode.nvim', {
  config = function()
    require('editor.config.zen-mode')
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
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
})
