local M = {}
M.loaded = false

local deps = {
  'lazygit',
  'rg',
}

M.check = function()
  vim.health.start('meatvim report')

  if M.loaded then
    vim.health.ok('meatvim loaded correctly')
  else
    vim.health.error('meatvim did not load correctly')
  end

  for _, dep in ipairs(deps) do
    if vim.fn.executable(dep) == 1 then
      vim.health.ok(dep .. ' is properly installed')
    else
      vim.health.error(dep .. ' is not properly installed')
    end
  end
end

return M
