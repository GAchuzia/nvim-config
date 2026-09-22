return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    spec = {
      { "<leader>b", group = "buffers" },
      { "<leader>c", group = "code" },
      { "<leader>f", group = "find" },
      { "<leader>g", group = "git" },
      { "<leader>gh", group = "git hunks" },
      { "<leader>p", group = "plugins / tools" },
      { "<leader>t", group = "terminal" },
      { "<leader>x", group = "diagnostics" },
    },
  },
}
