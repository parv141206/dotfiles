require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
map("n", "<C-k>", function()
  local term_id = "floatTerm"

  -- Check if the terminal is already open
  if vim.tbl_contains(vim.api.nvim_list_wins(), vim.fn.bufwinid(term_id)) then
    -- If it's open, close it
    require("nvchad.term").close(term_id)
  else
    -- If it's closed, open it with pwsh and increased size
    require("nvchad.term").toggle {
      pos = "float",
      id = term_id,
      float_opts = {
        relative = "editor",
        row = 0.1,    -- Adjusted position from the top
        col = 0.1,    -- Adjusted position from the left
        width = 0.8,  -- Increased width to 80% of the editor
        height = 0.6, -- Increased height to 60% of the editor
        border = "single",
      },
    }
  end
end, { desc = "Toggle floating terminal" })

-- Mapping for selecting all text in normal mode with Ctrl + A
map("n", "<C-a>", "ggVG", { desc = "Select all text" })

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
vim.wo.number = false
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
