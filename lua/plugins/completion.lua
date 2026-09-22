return {
  {
    "saghen/blink.cmp",
    version = "1.*", -- v2 requires Neovim 0.12.
    event = "InsertEnter",
    opts = {
      keymap = { preset = "default" },
      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 250 },
        list = { selection = { preselect = false, auto_insert = false } },
      },
      sources = { default = { "lsp", "path", "buffer" } },
      signature = { enabled = true },
      -- No native build needed.
      fuzzy = { implementation = "lua" },
    },
  },
}
