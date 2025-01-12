local api = vim.api

api.nvim_create_autocmd('FileType', {
  pattern = 'make',
  command = 'set noexpandtab',
})

api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = '*.go',
  command = 'setlocal noet ts=4 sw=4 sts=4',
})

api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

api.nvim_create_autocmd('BufReadPost', {
  pattern = '*',
  callback = function()
    local line = vim.fn.line('\'"')
    if line >= 1 and line <= vim.fn.line('$') then
      vim.cmd('normal! g`"')
    end
  end,
})

vim.api.nvim_set_keymap('t', '<leader><Esc>', [[<C-\><C-n>]], { noremap = true })

vim.api.nvim_set_keymap(
  'n',
  '<leader>tt',
  ':terminal<CR>',
  { noremap = true, silent = true, desc = '[T]oggle [T]erminal' }
)

vim.api.nvim_set_keymap('n', '<leader>sv', ':source $MYVIMRC<CR>', { desc = '[S]ource [V]imrc', noremap = true })
