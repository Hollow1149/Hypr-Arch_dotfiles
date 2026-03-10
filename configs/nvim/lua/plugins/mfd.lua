return {
  {
    "kungfusheep/mfd.nvim",
    lazy = true,
    config = function()
      require("mfd").setup({
        bright_comments = true,
      })
    end,
  },
}
