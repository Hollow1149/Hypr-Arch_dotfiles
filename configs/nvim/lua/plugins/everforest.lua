return {
  {
    "sainnhe/everforest",
    lazy = true,
    priority = 1000,
    config = function()
      vim.g.everforest_background = "hard"
      vim.g.everforest_enable_italic = 1
      vim.g.everforest_transparent_background = 0
      vim.g.everforest_dim_inactive_windows = 0
    end,
  },
}
