return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "javascript", "python", "go", "ruby", "c" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
}
