return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    cmd = "Telescope",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Search project text" },
      { "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Search word under cursor" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Search help" },
      { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Search keymaps" },
      { "<leader>fs", "<cmd>Telescope resume<cr>", desc = "Resume last search" },
      { "<leader>xx", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
    },
    opts = {
      defaults = {
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
          "--glob",
          "!.git/*",
        },
        file_ignore_patterns = {
          "node_modules[/\\]",
          "%.git[/\\]",
          "dist[/\\]",
          "build[/\\]",
          "vendor[/\\]",
        },
      },
      pickers = {
        find_files = {
          hidden = true,
          -- Use Telescope's fallback if rg is missing.
          find_command = vim.fn.executable("rg") == 1 and { "rg", "--files", "--glob", "!.git/*" }
            or nil,
        },
      },
    },
  },
}
