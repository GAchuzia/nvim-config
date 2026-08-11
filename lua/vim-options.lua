
vim.g.mapleader = " "

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.smarttab = true
vim.opt.backspace = { 'indent', 'eol', 'start' }

vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal left<CR>', {})


