vim.keymap.set('n', '<leader>tf', ':NvimTreeToggle<CR>', { desc = '[T]oggle [F]ile explorer' })

require('nvim-tree').setup {
  sort = {
    sorter = 'case_sensitive',
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    custom = { '^.git$' },
  },
  on_attach = function(bufnr)
    local api = require('nvim-tree.api')

    local opts = function(desc)
      return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    local git_add = function()
      local node = api.tree.get_node_under_cursor()
      local gs = node.git_status.file

      if gs == nil then
        gs = (node.git_status.dir.direct ~= nil and node.git_status.dir.direct[1])
          or (node.git_status.dir.indirect ~= nil and node.git_status.dir.indirect[1])
      end

      if gs == '??' or gs == 'MM' or gs == 'AM' or gs == ' M' then
        vim.cmd('silent !git add ' .. node.absolute_path)
      elseif gs == 'M ' or gs == 'A ' then
        vim.cmd('silent !git restore --staged ' .. node.absolute_path)
      end

      api.tree.reload()
    end

    api.config.mappings.default_on_attach(bufnr)

    vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent, opts('Up'))
    vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
    vim.keymap.set('n', 'ga', git_add, opts('Git add'))
    vim.keymap.set('n', '<TAB>', function(node)
      api.node.open.tab(node)
      vim.cmd.tabprev()
    end, opts('Open file in new tab'))
  end,
}
