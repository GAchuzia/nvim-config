return {
  "nvim-treesitter/nvim-treesitter",
  -- main requires Neovim 0.12.
  branch = "master",
  lazy = false,
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "lua",
      "javascript",
      "typescript",
      "tsx",
      "html",
      "css",
      "json",
      "ruby",
      "python",
      "sql",
      "go",
      "gomod",
      "gosum",
      "gowork",
      "c",
      "cpp",
      "markdown",
      "markdown_inline",
      "vim",
      "vimdoc",
      "query",
    },
    auto_install = false,
    highlight = { enable = true },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
