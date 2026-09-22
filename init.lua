-- Set leaders before loading plugins.
if vim.fn.has("nvim-0.11.3") == 0 or vim.fn.has("nvim-0.12") == 1 then
  error(
    "Use Neovim 0.11.3–0.11.x (tested on 0.11.6). Treesitter's master API does not support 0.12."
  )
end

require("config.options")
require("config.keymaps")
require("config.autocmds")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local result = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    error("Failed to install lazy.nvim. Check Git/network access:\n" .. result)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = { { import = "plugins" } },
  rocks = { enabled = false },
  change_detection = { notify = false },
})
