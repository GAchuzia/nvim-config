return {
  {
    "nvim-mini/mini.icons",
    version = "*",
    lazy = false,
    opts = {},
    config = function(_, opts)
      require("mini.icons").setup(opts)
      -- Serve plugins that still require("nvim-web-devicons").
      require("mini.icons").mock_nvim_web_devicons()
    end,
  },
}
