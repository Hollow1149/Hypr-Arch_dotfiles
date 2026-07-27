return {
  "snacks.nvim",
  opts = {
    image = {
      enabled = true,
    },
    terminal = {
      win = {
        style = "float",
        border = "rounded",
        width = 0.7,
        height = 0.7,
      },
    },
    dashboard = {
      preset = {
        pick = function(cmd, opts)
          return LazyVim.pick(cmd, opts)()
        end,
        header = [[
 ▐ ▄ ▄▄▄ .       ▌ ▐·▪          • ▌ ▄ ·. 
•█▌▐█▀▄.▀·▪     ▪█·█▌██ ▜ ▗     ·██ ▐███▪
▐█▐▐▌▐▀▀▪▄ ▄█▀▄ ▐█▐█•▐█·▐ ▜▘▛▘▌▌▐█ ▌▐▌▐█·
██▐█▌▐█▄▄▌▐█▌.▐▌ ███ ▐█▌▐▖▐▖▌ ▙▌██ ██▌▐█▌
▀▀ █▪ ▀▀▀  ▀█▄▀▪. ▀  ▀▀▀        ▀▀  █▪▀▀▀
 ]],
      },
    },
  },
}
