return {
  "stevearc/conform.nvim",
  cmd = "ConformInfo",
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      mode = { "n", "x" },
      desc = "Format buffer / selection",
    },
  },
  opts = {
    -- Manual formatting only.
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "prettier" },
      javascriptreact = { "prettier" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      html = { "prettier" },
      css = { "prettier" },
      json = { "prettier" },
      jsonc = { "prettier" },
      markdown = { "prettier" },
      python = { "ruff_format" },
      sql = { "sql_formatter" },
      mysql = { "sql_formatter" },
      go = { "gofmt" },
      c = { "clang_format" },
      cpp = { "clang_format" },
    },
  },
}
