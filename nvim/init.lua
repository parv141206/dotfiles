vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "
-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  -- lua/plugins/rose-pine.lua
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      vim.cmd("colorscheme rose-pine")
    end
  },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
  },
  {
    'barrett-ruth/live-server.nvim',
    build = 'pnpm add -g live-server',
    cmd = { 'LiveServerStart', 'LiveServerStop' },
    config = true
  },
  {
    "azratul/live-share.nvim",
    dependencies = {
      "jbyuki/instant.nvim",
    }
  },
  -- {
  --   "supermaven-inc/supermaven-nvim",
  --   config = function()
  --     require("supermaven-nvim").setup({})
  --   end,
  -- },
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },
  {
    "hedyhli/outline.nvim",
    config = function()
      -- Example mapping to toggle outline
      vim.keymap.set("n", "<leader>", "<cmd>Outline<CR>",
        { desc = "Toggle Outline" })

      require("outline").setup {
        -- Your setup opts here (leave empty to use defaults)
      }
    end,
  },
  { import = "plugins" },
}, lazy_config)
require("outline").setup({})
-- require('rose-pine').setup({
--   styles = {
--     italic = true, -- Enables italics globally
--   }
-- })

--
-- vim.api.nvim_set_hl(0, "Comment", { fg = "#6e6a86", italic = true })  -- Italic comments
-- vim.api.nvim_set_hl(0, "Function", { fg = "#9ccfd8", italic = true }) -- Italic functions
-- vim.api.nvim_set_hl(0, "Keyword", { fg = "#eb6f92", italic = true })  -- Italic keywords
-- vim.api.nvim_set_hl(0, "Type", { fg = "#f6c177", italic = true })     -- Italic type names
-- vim.api.nvim_set_hl(0, "String", { fg = "#f6c177", italic = false })  -- Keep strings normal
--

-- setup must be called before loading
require("ibl").setup()

-- Configuration for nvim-cmp
local cmp = require "cmp"

local options = {
  completion = { completeopt = "menu,menuone" },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif require("luasnip").expand_or_jumpable() then
        require("luasnip").expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif require("luasnip").jumpable(-1) then
        require("luasnip").jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = {
    { name = "supermaven" },
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "nvim_lua" },
    { name = "path" },
  },
}

-- Set up nvim-cmp with the options defined above
cmp.setup(options)


require("menu")
-- For keyboard users
vim.keymap.set("n", "<C-t>", function() require("menu").open("default") end, {})

-- For mouse users (e.g., in NvimTree)
vim.keymap.set("n", "<RightMouse>", function()
  vim.cmd.exec '"normal! \\<RightMouse>"'
  local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
  require("menu").open(options, { mouse = true })
end, {})
-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")
require("volt")
require "options"
require "nvchad.autocmds"
vim.schedule(function()
  require "mappings"
end)

-- Define options for the mapping
local opts = { noremap = true, silent = true }

-- Map Escape key to exit terminal mode
vim.api.nvim_set_keymap('t', '<Esc>', [[<C-\><C-n>]], opts)

-- Optionally, map 'jj' or 'kj' to exit terminal mode
vim.api.nvim_set_keymap('t', 'jj', [[<C-\><C-n>]], opts)
vim.api.nvim_set_keymap('t', 'kj', [[<C-\><C-n>]], opts)

-- Resize up
vim.api.nvim_set_keymap('n', '<C-S-Up>', ':resize -2<CR>', opts)
-- Resize down
vim.api.nvim_set_keymap('n', '<C-S-Down>', ':resize +2<CR>', opts)
-- Resize left
vim.api.nvim_set_keymap('n', '<C-S-Left>', ':vertical resize -2<CR>', opts)
-- Resize right
vim.api.nvim_set_keymap('n', '<C-S-Right>', ':vertical resize +2<CR>', opts)
vim.o.shell = "bash"

vim.opt.guifont = "Cascadia Code:h12"

vim.opt.fillchars = { eob = '~' }

-- default config:
require('peek').setup({
  auto_load = true,        -- whether to automatically load preview when
  -- entering another markdown buffer
  close_on_bdelete = true, -- close preview window on buffer delete

  syntax = true,           -- enable syntax highlighting, affects performance

  theme = 'dark',          -- 'dark' or 'light'

  update_on_change = true,

  app = 'webview', -- 'webview', 'browser', string or a table of strings
  -- explained below

  filetype = { 'markdown' }, -- list of filetypes to recognize as markdown

  -- relevant if update_on_change is true
  throttle_at = 200000,   -- start throttling when file exceeds this
  -- amount of bytes in size
  throttle_time = 'auto', -- minimum amount of time in milliseconds
  -- that has to pass before starting new render
})

local highlight = {
  "Rainbow1",
  "Rainbow2",
  "Rainbow3",
  "Rainbow4",
  "Rainbow5",
  "Rainbow6",
}

local hooks = require "ibl.hooks"

hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, "Rainbow1", { fg = "#eb6f92", blend = 30 }) -- Rose (Pink)
  vim.api.nvim_set_hl(0, "Rainbow2", { fg = "#f6c177", blend = 30 }) -- Gold (Yellow-Orange)
  vim.api.nvim_set_hl(0, "Rainbow3", { fg = "#9ccfd8", blend = 30 }) -- Foam (Cyan)
  vim.api.nvim_set_hl(0, "Rainbow4", { fg = "#c4a7e7", blend = 30 }) -- Iris (Purple)
  vim.api.nvim_set_hl(0, "Rainbow5", { fg = "#31748f", blend = 30 }) -- Pine (Dark Cyan)
  vim.api.nvim_set_hl(0, "Rainbow6", { fg = "#e0def4", blend = 30 }) -- Text (Soft White)
end)

require("ibl").setup {
  indent = {
    char = "┆", -- Thin dotted line alternative
    highlight = highlight,
  }
}


vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"

-- vim.api.nvim_set_keymap('i', '<C-h>', '<Left>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('i', '<C-j>', '<Down>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('i', '<C-k>', '<Up>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('i', '<C-l>', '<Right>', { noremap = true, silent = true })
--
-- Enable relative numbering
vim.opt.relativenumber = true
vim.opt.number = true -- Keeps the current line's absolute number visible

-- Disable arrow keys in normal, insert, and visual modes
-- local modes = { 'n', 'i', 'v' }
-- for _, mode in ipairs(modes) do
--   vim.api.nvim_set_keymap(mode, '<Up>', '<Nop>', { noremap = true, silent = true })
--   vim.api.nvim_set_keymap(mode, '<Down>', '<Nop>', { noremap = true, silent = true })
--   vim.api.nvim_set_keymap(mode, '<Left>', '<Nop>', { noremap = true, silent = true })
--   vim.api.nvim_set_keymap(mode, '<Right>', '<Nop>', { noremap = true, silent = true })
-- end
