local M = {}
local plugins = {}
local plugins_seen = {}

local utils = require('core.utils')

function M.add_plugin(name, opts)
  if plugins_seen[name] then
    print(string.format('[Warning] Plugin %s already added!', name))
    return
  end
  plugins[#plugins + 1] = vim.tbl_extend('force', { name }, opts or {})
  plugins_seen[name] = true
end

local function load_sub_components(ext)
  for _, m in ipairs(utils.find_modules(utils.script_path(), ext .. '.lua')) do
    require(m .. '.' .. ext)
  end
end

function M.setup_plugins()
  load_sub_components('plugins')
  local lazy_path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

  if not vim.loop.fs_stat(lazy_path) then
    print('installing lazy.nvim')
    vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      '--depth=1',
      'git@github.com:folke/lazy.nvim.git',
      '--branch=stable',
      lazy_path,
    })
    print('lazy.nvim installation complete')
  end
  vim.opt.rtp:prepend(lazy_path)
  require('lazy').setup(plugins)
end

return M
