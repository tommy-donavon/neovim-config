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
        { icon = ' ', key = 'p', desc = 'List Projects', action = ':Telescope projects' },
        { icon = ' ', key = 'f', desc = 'Find File', action = ':Telescope find_files' },
        { icon = '󰊄 ', key = 't', desc = 'Find Text', action = ':Telescope live_grep' },
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
      files = { hidden = true, ignored = true },
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

-- keymaps
vim.keymap.set({ 'v', 'n' }, '<leader>tg', snacks.lazygit.open, { desc = '[T]oggle Lazy [G]it' })
vim.keymap.set({ 'v', 'n' }, '<leader>tz', snacks.zen.zen, { desc = '[T]oggle [Z]en mode' })
vim.keymap.set('n', '<leader>tt', snacks.terminal.toggle, { desc = '[T]oggle [T]erminal' })
vim.keymap.set('n', '<leader>tf', snacks.picker.explorer, { desc = '[T]oggle [F]ile explorer', silent = true })
