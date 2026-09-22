return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      on_attach = function(bufnr)
        local gs = require("gitsigns")
        local function map(lhs, rhs, desc)
          vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
        end
        map("]h", function()
          gs.nav_hunk("next")
        end, "Next Git hunk")
        map("[h", function()
          gs.nav_hunk("prev")
        end, "Previous Git hunk")
        map("<leader>ghp", gs.preview_hunk, "Preview hunk")
        map("<leader>ghs", gs.stage_hunk, "Stage / unstage hunk")
        map("<leader>ghr", gs.reset_hunk, "Reset hunk (discard changes)")
        map("<leader>gb", gs.blame_line, "Blame line")
        map("<leader>gd", gs.diffthis, "Diff against index")
      end,
    },
  },
}
