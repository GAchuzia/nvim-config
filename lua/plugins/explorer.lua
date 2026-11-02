return {
  {
    "stevearc/oil.nvim",
    -- Eager so it can claim netrw's role before `nvim <dir>` is handled.
    lazy = false,
    dependencies = { "nvim-mini/mini.icons" },
    keys = {
      { "<leader>e", "<cmd>Oil<cr>", desc = "Open parent directory" },
      { "<C-n>", "<cmd>Oil<cr>", desc = "Open parent directory" },
    },
    opts = {
      default_file_explorer = true,
      delete_to_trash = true,
      view_options = { show_hidden = true },
    },
  },
}
