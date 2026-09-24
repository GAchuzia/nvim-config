return {
  "goolord/alpha-nvim",
  lazy = false,
  dependencies = { "nvim-mini/mini.icons", "nvim-lua/plenary.nvim" },
  opts = { theme = "startify" },
  config = function(_, opts)
    local alpha = require("alpha")
    local names = { "dashboard", "startify", "theta" }
    local descriptions = {
      dashboard = "Centered banner and shortcuts",
      startify = "Compact layout with recent files",
      theta = "Centered banner, recent files, and shortcuts",
    }

    local function configure(name)
      local theme = require("alpha.themes." .. name)
      local button = theme.button or require("alpha.themes.dashboard").button
      local buttons = {
        button("e", "New file", "<cmd>enew<cr>"),
        button("f", "Find files", "<cmd>Telescope find_files<cr>"),
        button("r", "Recent files", "<cmd>Telescope oldfiles<cr>"),
        button("s", "Search text", "<cmd>Telescope live_grep<cr>"),
        button("d", "Choose layout", "<cmd>Dashboard<cr>"),
        button("q", "Quit", "<cmd>qa<cr>"),
      }
      if name == "startify" then
        theme.section.bottom_buttons.val = { table.remove(buttons) }
        theme.section.top_buttons.val = buttons
      elseif name == "theta" then
        theme.buttons.val = buttons
      else
        theme.section.buttons.val = buttons
      end
      theme.config.opts.autostart = #vim.api.nvim_list_uis() > 0
      alpha.setup(theme.config)
    end

    local function preview(name)
      if not name then
        return
      end
      if not vim.tbl_contains(names, name) then
        return vim.notify("Choose dashboard, startify, or theta.", vim.log.levels.WARN)
      end
      if vim.bo.filetype == "alpha" then
        vim.cmd.Alpha()
      end
      configure(name)
      alpha.start(false)
    end

    configure(opts.theme)
    vim.api.nvim_create_user_command("Dashboard", function(args)
      if args.args ~= "" then
        preview(args.args)
      else
        vim.ui.select(names, {
          prompt = "Dashboard layout:",
          format_item = function(name)
            return name .. " — " .. descriptions[name]
          end,
        }, preview)
      end
    end, {
      nargs = "?",
      complete = function()
        return names
      end,
      desc = "Choose a dashboard layout",
    })
  end,
}
