local g = vim.g
local opt = vim.opt

g.mapleader = ' '
g.maplocalleader = ' '

opt.complete = ''

vim.cmd('syntax on')
vim.cmd('filetype plugin indent on')

opt.timeoutlen = 500
opt.linebreak = true
opt.breakindent = true
opt.mouse = 'a'
opt.number = true
opt.relativenumber = true
opt.showbreak = '+++'
opt.showmatch = true
opt.showmode = true
opt.undofile = true
opt.visualbell = true

opt.clipboard:append('unnamedplus')
opt.hlsearch = true
opt.ignorecase = true
opt.incsearch = true
opt.smartcase = true

local indent = 4

opt.autoindent = true
opt.expandtab = true
opt.shiftwidth = indent
opt.softtabstop = indent
opt.tabstop = indent

opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

opt.ruler = true
opt.undolevels = 1000

opt.spelllang = 'en_us'
opt.spell = true

opt.shell = os.getenv('SHELL') or 'zsh'

vim.cmd([[
	hi Pmenu ctermfg=white ctermbg=238
]])
