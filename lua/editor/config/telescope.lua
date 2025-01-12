local telescope = require('telescope')

local fb_actions = require('telescope').extensions.file_browser.actions

local previewers = require('telescope.previewers')

local new_maker = function(filepath, bufnr, opts)
  opts = opts or {}

  filepath = vim.fn.expand(filepath)
  vim.loop.fs_stat(filepath, function(_, stat)
    if not stat then
      return
    end
    if stat.size > 100000 then
      return
    else
      previewers.buffer_previewer_maker(filepath, bufnr, opts)
    end
  end)
end

local theme = 'ivy'

telescope.setup {
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--hidden',
      '--glob=!**/.git/*',
      '--glob=!**/.idea/*',
      '--glob=!**/.vscode/*',
      '--glob=!**/build/*',
      '--glob=!**/dist/*',
      '--glob=!**/yarn.lock',
      '--glob=!**/package-lock.json',
      '--glob=!**/node_modules/*',
    },
    mappings = {
      i = {
        ['<C-a>'] = { '<esc>0i', type = 'command' },
        ['<Esc>'] = require('telescope.actions').close,
      },
    },
    selection_caret = '  ',
    entry_prefix = '  ',
    initial_mode = 'insert',
    selection_strategy = 'reset',
    sorting_strategy = 'ascending',
    layout_strategy = 'horizontal',
    -- file_ignore_patterns = { 'node_modules', '.git' },
    layout_config = {
      horizontal = {
        prompt_position = 'top',
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
    path_display = { 'smart' },
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require('telescope.previewers').vim_buffer_cat.new,
    grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
    buffer_previewer_maker = new_maker,
  },
  extensions = {
    ['ui-select'] = {
      require('telescope.themes').get_cursor {},
    },
    file_browser = {
      theme = theme,
      mappings = {
        ['i'] = {
          ['<C-h>'] = fb_actions.goto_parent_dir,
          ['<C-e>'] = fb_actions.rename,
          ['<C-c>'] = fb_actions.create,
        },
      },
    },
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case',
    },
    media_files = {
      filetypes = { 'png', 'webp', 'jpg', 'jpeg' },
      find_cmd = 'rg', -- find command (defaults to `fd`)
    },

    notify = {
      stages = 'fade_in_slide_out',
      on_open = nil,
      on_close = nil,
      render = 'default',
      timeout = 5000,
      background_colour = 'Normal',
      minimum_width = 50,
      icons = {
        ERROR = '',
        WARN = '',
        INFO = '',
        DEBUG = '',
        TRACE = '✎',
      },
    },
  },
  pickers = {
    buffers = {
      theme = theme,
    },
    find_files = {
      theme = theme,
      hidden = true,
      find_command = {
        'rg',
        '--files',
        '--hidden',
        '--glob=!**/.git/*',
        '--glob=!**/.idea/*',
        '--glob=!**/.vscode/*',
        '--glob=!**/build/*',
        '--glob=!**/dist/*',
        '--glob=!**/yarn.lock',
        '--glob=!**/package-lock.json',
        '--glob=!**/node_modules/*',
      },
    },
    oldfiles = {
      theme = theme,
      hidden = true,
    },
    live_grep = {
      debounce = 100,
      theme = theme,
      on_input_filter_cb = function(prompt)
        return { prompt = prompt:gsub('%s', '.*') }
      end,
    },
    current_buffer_fuzzy_find = {
      theme = theme,
    },
    commands = {
      theme = theme,
    },
    lsp_document_symbols = {
      theme = theme,
    },
    diagnostics = {
      theme = theme,
      initial_mode = 'normal',
    },
    lsp_references = {
      theme = 'cursor',
      initial_mode = 'normal',
      layout_config = {
        width = 0.8,
        height = 0.4,
      },
    },
    lsp_code_actions = {
      theme = 'cursor',
      initial_mode = 'normal',
    },
  },
}

telescope.load_extension('projects')
telescope.load_extension('file_browser')

telescope.load_extension('notify')
vim.notify = require('notify')

pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

vim.keymap.set('n', '<leader>/', function()
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>s/', function()
  builtin.live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end, { desc = '[S]earch [/] in Open Files' })

vim.keymap.set('n', '<leader>sn', function()
  builtin.find_files { cwd = vim.fn.stdpath('config') }
end, { desc = '[S]earch [N]eovim files' })

vim.keymap.set('n', '<leader>fd', function()
  vim.diagnostic.open_float()
end, { desc = 'Open [F]loating [D]iagnostics window' })
