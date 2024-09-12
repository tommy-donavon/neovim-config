local toggleterm = require('toggleterm')

toggleterm.setup({
  highlights = {
    Normal = { link = 'Normal' },
    NormalNC = { link = 'NormalNC' },
    NormalFloat = { link = 'NormalFloat' },
    FloatBorder = { link = 'FloatBorder' },
    StatusLine = { link = 'StatusLine' },
    StatusLineNC = { link = 'StatusLineNC' },
    WinBar = { link = 'WinBar' },
    WinBarNC = { link = 'WinBarNC' },
  },
  size = 10,
  --@param t Terminal
  on_create = function(t)
    vim.opt_local.foldcolumn = '0'
    vim.opt_local.signcolumn = 'no'
    if t.hidden then
      local function toggle()
        t:toggle()
      end
      vim.keymap.set('n', '<leader>ti', toggle, { desc = 'terminal', buffer = t.bufnr })
    end
  end,
  shading_factor = 2,
  float_opts = { border = 'rounded' },
})
