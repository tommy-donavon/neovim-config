local snacks = require('snacks')

snacks.setup {
  animate = {
    enable = true,
    duration = 20,
    easing = 'linear',
    fps = 60,
  },
  bigfile = { enable = true },
  dashboard = {
    enable = true,
    width = 60,
    pane_gap = 5,
    preset = {
      keys = {
        { icon = ' ', key = 'r', desc = 'Recent Files', action = ":lua Snacks.dashboard.pick('oldfiles')" },
        { icon = ' ', key = 'p', desc = 'List Projects', action = ":lua Snacks.dashboard.pick('projects')" },
        { icon = ' ', key = 'f', desc = 'Find File', action = ":lua Snacks.dashboard.pick('find_files')" },
        { icon = '󰊄 ', key = 't', desc = 'Find Text', action = ":lua Snacks.dashboard.pick('live_grep')" },
        { icon = '󰒲 ', key = 'L', desc = 'Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
        { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
      },
    },
    sections = {
      {
        section = 'terminal',
        cmd = 'chafa --passthrough tmux '
          .. os.getenv('HOME')
          .. '/.config/nvim/static/dashboard.webp -f symbols -s 60x60 -c full --fg-only --symbols braille --clear',
        height = 18,
        padding = 1,
      },
      {
        pane = 2,
        { section = 'keys', gap = 2, padding = 1 },
        { section = 'startup' },
      },
    },
  },

  lazygit = {
    enable = true,
    configure = true,
  },
  picker = {
    sources = {
      files = { hidden = true, ignored = false },
    },

    toggles = {
      follow = 'f',
      hidden = 'h',
      ignored = 'i',
      modified = 'm',
      regex = { icon = 'R', value = false },
    },
    explorer = {
      finder = 'rg',
      sort = { fields = { 'sort' } },
      tree = true,
      supports_live = true,
      follow_file = true,
      focus = 'list',
      auto_close = false,
      jump = { close = false },
      layout = { preset = 'sidebar', preview = false },
      formatters = { file = { filename_only = true } },
      matcher = { sort_empty = true },
      config = function(opts)
        return require('snacks.picker.source.explorer').setup(opts)
      end,
      win = {
        list = {
          keys = {
            ['<BS>'] = 'explorer_up',
            ['a'] = 'explorer_add',
            ['d'] = 'explorer_del',
            ['r'] = 'explorer_rename',
            ['c'] = 'explorer_copy',
            ['m'] = 'explorer_move',
            ['y'] = 'explorer_yank',
            ['<c-c>'] = 'explorer_cd',
            ['.'] = 'explorer_focus',
          },
        },
      },
    },
  },

  statuscolumn = {
    enable = true,
    left = { 'mark', 'sign' },
    right = { 'fold', 'git' },
    folds = {
      open = false,
      git_hl = false,
    },
    git = {
      patterns = { 'GitSign', 'MiniDiffSign' },
    },
    refresh = 50,
  },
  scroll = { enable = true },
  terminal = {
    enable = true,
    win = { style = 'terminal' },
  },
  zen = { enable = true },
}

-- keymaps --

local pickers = snacks.picker

-- search --
vim.keymap.set('n', '<leader>sk', pickers.keymaps, { desc = '[s]earch [k]eymaps' })
vim.keymap.set('n', '<leader>sf', pickers.files, { desc = '[s]earch [f]iles' })
vim.keymap.set('n', '<leader>sg', pickers.grep, { desc = '[s]earch by [g]rep' })
vim.keymap.set('n', '<leader>sd', pickers.diagnostics, { desc = '[s]earch [d]iagnostics' })
vim.keymap.set('n', '<leader>sr', pickers.recent, { desc = '[s]earch [r]ecent files' })

vim.keymap.set('n', '<leader>sh', snacks.picker.help, { desc = '[s]earch [h]elp' })
vim.keymap.set({ 'v', 'n' }, '<leader>tg', snacks.lazygit.open, { desc = '[t]oggle Lazy [g]it' })
vim.keymap.set({ 'v', 'n' }, '<leader>tz', snacks.zen.zen, { desc = '[t]oggle [z]en mode' })
vim.keymap.set('n', '<leader>tt', snacks.terminal.toggle, { desc = '[t]oggle [t]erminal' })
vim.keymap.set('n', '<leader>tf', snacks.picker.explorer, { desc = '[t]oggle [f]ile explorer', silent = true })
