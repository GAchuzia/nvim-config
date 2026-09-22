local map = vim.keymap.set

map("n", "<leader>w", "<cmd>write<cr>", { desc = "Save buffer" })
map("n", "<leader>q", "<cmd>quit<cr>", { desc = "Quit window" })
map("n", "<leader>e", "<cmd>Lexplore<cr>", { desc = "Toggle file explorer" })
map("n", "<C-n>", "<cmd>Lexplore<cr>", { desc = "Toggle file explorer" })
map("n", "<leader>tt", "<cmd>botright 12split | terminal<cr>", { desc = "New terminal" })
map("n", "<leader>gg", function()
  if vim.fn.executable("lazygit") == 0 then
    return vim.notify("Install lazygit and add it to PATH first.", vim.log.levels.WARN)
  end
  local root = vim.fs.root(vim.fn.getcwd(), ".git")
  if not root then
    return vim.notify("Use :cd to enter a Git repository first.", vim.log.levels.WARN)
  end
  vim.cmd.tabnew()
  local win, buf = vim.api.nvim_get_current_win(), vim.api.nvim_get_current_buf()
  vim.fn.jobstart({ "lazygit" }, {
    term = true,
    cwd = root,
    on_exit = function(_, code)
      if code == 0 then
        vim.schedule(function()
          if vim.api.nvim_win_is_valid(win) and vim.api.nvim_win_get_buf(win) == buf then
            pcall(vim.api.nvim_win_close, win, true)
          end
          if vim.api.nvim_buf_is_valid(buf) then
            vim.api.nvim_buf_delete(buf, { force = true })
          end
        end)
      end
    end,
  })
  vim.cmd.startinsert()
end, { desc = "Git dashboard (LazyGit)" })
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })
map("n", "<leader>|", "<cmd>vsplit<cr>", { desc = "Split vertically" })
map("n", "<leader>-", "<cmd>split<cr>", { desc = "Split horizontally" })
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line diagnostics" })
map("n", "<leader>cl", "<cmd>checkhealth vim.lsp<cr>", { desc = "LSP health" })
map("n", "<leader>xl", vim.diagnostic.setloclist, { desc = "Buffer diagnostics list" })
map("n", "<leader>pm", "<cmd>Mason<cr>", { desc = "Manage language tools" })
map("n", "<leader>pl", "<cmd>Lazy<cr>", { desc = "Manage plugins" })
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Terminal normal mode" })
