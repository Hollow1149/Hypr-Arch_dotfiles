return {
  {
    "scottmckendry/cyberdream.nvim",
    lazy = true,
    priority = 1000,
    config = function()
      require("cyberdream").setup({
        variant = "default",
        transparent = false,
        saturation = 1,
        italic_comments = true,
        hide_fillchars = false,
        borderless_pickers = false,
        terminal_colors = true,
        cache = false,
      })
    end,
  },
}
