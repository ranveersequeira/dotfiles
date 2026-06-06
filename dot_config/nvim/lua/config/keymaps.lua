local map = vim.keymap.set

local function toggle_line_comment()
  local keys = vim.api.nvim_replace_termcodes("gcc", true, false, true)
  vim.api.nvim_feedkeys(keys, "m", false)
end

local function toggle_visual_comment()
  local keys = vim.api.nvim_replace_termcodes("gc", true, false, true)
  vim.api.nvim_feedkeys(keys, "m", false)
end

map("n", "<leader>/", toggle_line_comment, { desc = "Toggle Comment" })
map("x", "<leader>/", toggle_visual_comment, { desc = "Toggle Comment" })

map("n", "<leader>fg", LazyVim.pick("live_grep"), { desc = "Grep (Root Dir)" })

map("n", "<leader>xd", vim.diagnostic.setloclist, { desc = "Buffer Diagnostics List" })
map("n", "<leader>xq", vim.diagnostic.setqflist, { desc = "Workspace Diagnostics List" })
map("n", "]e", function()
  vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
end, { desc = "Next Error" })
map("n", "[e", function()
  vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
end, { desc = "Previous Error" })
map("n", "]w", function()
  vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.WARN })
end, { desc = "Next Warning" })
map("n", "[w", function()
  vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.WARN })
end, { desc = "Previous Warning" })

map({ "n", "x" }, "<M-j>", "10j", { desc = "Move Down 10 Lines" })
map({ "n", "x" }, "<M-k>", "10k", { desc = "Move Up 10 Lines" })
map("n", "<M-d>", "<C-d>zz", { desc = "Page Down Centered" })
map("n", "<M-u>", "<C-u>zz", { desc = "Page Up Centered" })
