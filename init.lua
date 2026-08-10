-- Bootstrap lazy.nvim
vim.g.mapleader = " "
vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal left<CR>', {})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local clone = function()
    return vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      lazypath,
    })
  end

  local result = clone()
  if vim.v.shell_error ~= 0 then
    vim.fn.system({
      "git",
      "config",
      "--global",
      "--add",
      "safe.directory",
      lazypath,
    })
    result = clone()
    if vim.v.shell_error ~= 0 then
      error("Failed to clone lazy.nvim: " .. result)
    end
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = { import = "plugins" },
  rocks = { enabled = true },
})
