return {
  {
    dir = "/Users/ranveer.kumar/Personal/agentify-nvim",
    name = "agentify.nvim",
    lazy = false,
    config = function()
      require("agentify").setup()

      vim.keymap.set("i", "<C-l>", function()
        require("agentify").accept()
      end, { desc = "Agentify Accept Suggestion" })

      vim.keymap.set("i", "<M-w>", function()
        require("agentify").accept_word()
      end, { desc = "Agentify Accept Word" })

      vim.keymap.set("i", "<M-]>", function()
        require("agentify").dismiss()
      end, { desc = "Agentify Dismiss Suggestion" })
    end,
  },
}
