-- ~/.config/nvim/lua/plugins/snacks.lua
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    terminal = {
      enabled = true,
      layout = "float",
      float = {
        border = "rounded",
        width = 80,
        height = 20,
      },
    },
    picker = {
      enabled = true,
      sources = {
        explorer = {
          hidden = true, -- Show dotfiles
          ignored = true, -- Show git-ignored files
          layout = {
            layout = {
              position = "right", -- keep explorer on right
            },
          },
        },
      },
    },
  },
  keys = {
    {
      "<leader>e",
      function()
        require("snacks").explorer() -- Use the explorer picker
      end,
      desc = "Toggle Snacks Explorer",
    },
    {
      "<leader>tt",
      function()
        require("snacks").terminal.toggle()
      end,
      desc = "Toggle Terminal",
    },
  },
}
