return {
  "NickvanDyke/opencode.nvim",
  dependencies = {
    {
      "folke/snacks.nvim",
      opts = {
        input = {},
        picker = {},
        terminal = {},
      },
    },
  },

  config = function()
    local oc = require("opencode")

    ---@type opencode.Opts
    vim.g.opencode_opts = {
      -- start minimal, tune later
      model = "gemini3pro",
    }

    -- Needed so diffs update if AI edits files
    vim.o.autoread = true

    ------------------------------------------------------------------
    -- <leader>a → AI / Ask / OpenCode
    ------------------------------------------------------------------

    -- Toggle OpenCode UI
    vim.keymap.set("n", "<leader>aa", function()
      oc.toggle()
    end, { desc = "Opencode toggle" })

    -- Ask about current context (line / selection)
    vim.keymap.set({ "n", "x" }, "<leader>aq", function()
      oc.ask("@this: ", { submit = true })
    end, { desc = "Opencode ask" })

    -- Action picker (explain / refactor / fix / generate)
    vim.keymap.set({ "n", "x" }, "<leader>ax", function()
      oc.select()
    end, { desc = "Opencode action picker" })

    ------------------------------------------------------------------
    -- Context injection
    ------------------------------------------------------------------

    -- Operator-pending: add line / selection
    vim.keymap.set({ "n", "x" }, "<leader>al", function()
      return oc.operator("@this ")
    end, {
      expr = true,
      desc = "Opencode add line / selection",
    })

    -- Explicit range
    vim.keymap.set("n", "<leader>ar", function()
      return oc.operator("@this ")
    end, {
      expr = true,
      desc = "Opencode add range",
    })

    -- Current file
    vim.keymap.set("n", "<leader>af", function()
      oc.command("context.file")
    end, { desc = "Opencode add file" })

    -- Entire buffer
    vim.keymap.set("n", "<leader>ab", function()
      oc.command("context.buffer")
    end, { desc = "Opencode add buffer" })

    ------------------------------------------------------------------
    -- Session navigation (inside OpenCode output)
    ------------------------------------------------------------------

    vim.keymap.set("n", "<leader>au", function()
      oc.command("session.half.page.up")
    end, { desc = "Opencode half page up" })

    vim.keymap.set("n", "<leader>ad", function()
      oc.command("session.half.page.down")
    end, { desc = "Opencode half page down" })

    ------------------------------------------------------------------
    -- tmux integration (power move)
    ------------------------------------------------------------------

    -- Spawn OpenCode in a tmux side pane
    vim.keymap.set("n", "<leader>at", function()
      vim.fn.system("tmux split-window -h 'opencode ask'")
    end, { desc = "Open OpenCode in tmux pane" })
  end,
}
