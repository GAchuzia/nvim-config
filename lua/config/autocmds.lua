local group = vim.api.nvim_create_augroup("UserConfig", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = group,
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = group,
  callback = function(event)
    local function map(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = event.buf, desc = desc })
    end
    map("gd", vim.lsp.buf.definition, "Go to definition")
    map("gD", vim.lsp.buf.declaration, "Go to declaration")
    map("gr", "<cmd>Telescope lsp_references<cr>", "Find references")
    map("gI", "<cmd>Telescope lsp_implementations<cr>", "Find implementations")
    map("gy", vim.lsp.buf.type_definition, "Go to type definition")
    map("K", vim.lsp.buf.hover, "Hover documentation")
    map("<leader>cr", vim.lsp.buf.rename, "Rename symbol")
    map("<leader>cs", "<cmd>Telescope lsp_document_symbols<cr>", "Document symbols")
    vim.keymap.set({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, {
      buffer = event.buf,
      desc = "Code action",
    })
  end,
})

vim.diagnostic.config({
  severity_sort = true,
  underline = true,
  update_in_insert = false,
  virtual_text = { spacing = 2, source = "if_many" },
  float = { border = "rounded", source = true },
})
