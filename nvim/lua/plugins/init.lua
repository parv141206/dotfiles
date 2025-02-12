return {
  -- {
  --   "folke/snacks.nvim",
  --   priority = 1000,
  --   lazy = false,
  --   ---@type snacks.Config
  --   opts = {
  --     bigfile = { enabled = true },
  --     dashboard = { enabled = true },
  --     indent = { enabled = true },
  --     input = { enabled = true },
  --     notifier = {
  --       enabled = true,
  --       timeout = 3000,
  --     },
  --     quickfile = { enabled = true },
  --     scroll = { enabled = true },
  --     statuscolumn = { enabled = true },
  --     words = { enabled = true },
  --     styles = {
  --       notification = {
  --         -- wo = { wrap = true } -- Wrap notifications
  --       }
  --     }
  --   },
  --   keys = {
  --     { "<leader>z",  function() Snacks.zen() end,                     desc = "Toggle Zen Mode" },
  --     { "<leader>Z",  function() Snacks.zen.zoom() end,                desc = "Toggle Zoom" },
  --     { "<leader>.",  function() Snacks.scratch() end,                 desc = "Toggle Scratch Buffer" },
  --     { "<leader>S",  function() Snacks.scratch.select() end,          desc = "Select Scratch Buffer" },
  --     { "<leader>n",  function() Snacks.notifier.show_history() end,   desc = "Notification History" },
  --     { "<leader>bd", function() Snacks.bufdelete() end,               desc = "Delete Buffer" },
  --     { "<leader>cR", function() Snacks.rename.rename_file() end,      desc = "Rename File" },
  --     { "<leader>gB", function() Snacks.gitbrowse() end,               desc = "Git Browse",                  mode = { "n", "v" } },
  --     { "<leader>gb", function() Snacks.git.blame_line() end,          desc = "Git Blame Line" },
  --     { "<leader>gf", function() Snacks.lazygit.log_file() end,        desc = "Lazygit Current File History" },
  --     { "<leader>gg", function() Snacks.lazygit() end,                 desc = "Lazygit" },
  --     { "<leader>gl", function() Snacks.lazygit.log() end,             desc = "Lazygit Log (cwd)" },
  --     { "<leader>un", function() Snacks.notifier.hide() end,           desc = "Dismiss All Notifications" },
  --     { "<c-/>",      function() Snacks.terminal() end,                desc = "Toggle Terminal" },
  --     { "<c-_>",      function() Snacks.terminal() end,                desc = "which_key_ignore" },
  --     { "]]",         function() Snacks.words.jump(vim.v.count1) end,  desc = "Next Reference",              mode = { "n", "t" } },
  --     { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference",              mode = { "n", "t" } },
  --     {
  --       "<leader>N",
  --       desc = "Neovim News",
  --       function()
  --         Snacks.win({
  --           file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
  --           width = 0.6,
  --           height = 0.6,
  --           wo = {
  --             spell = false,
  --             wrap = false,
  --             signcolumn = "yes",
  --             statuscolumn = " ",
  --             conceallevel = 3,
  --           },
  --         })
  --       end,
  --     }
  --   },
  --   init = function()
  --     vim.api.nvim_create_autocmd("User", {
  --       pattern = "VeryLazy",
  --       callback = function()
  --         -- Setup some globals for debugging (lazy-loaded)
  --         _G.dd = function(...)
  --           Snacks.debug.inspect(...)
  --         end
  --         _G.bt = function()
  --           Snacks.debug.backtrace()
  --         end
  --         vim.print = _G.dd -- Override print to use snacks for `:=` command
  --
  --         -- Create some toggle mappings
  --         Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
  --         Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
  --         Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
  --         Snacks.toggle.diagnostics():map("<leader>ud")
  --         Snacks.toggle.line_number():map("<leader>ul")
  --         Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map(
  --         "<leader>uc")
  --         Snacks.toggle.treesitter():map("<leader>uT")
  --         Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
  --         Snacks.toggle.inlay_hints():map("<leader>uh")
  --         Snacks.toggle.indent():map("<leader>ug")
  --         Snacks.toggle.dim():map("<leader>uD")
  --       end,
  --     })
  --   end,
  -- },
  -- install without yarn or npm
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },

  -- install with yarn or npm
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local conform = require("conform")

      conform.setup({
        format_on_save = {
          lsp_fallback = true,
          async = false,
          timeout_ms = 2000,
        },
        formatters_by_ft = {
          javascript = { "prettier" },
          javascriptreact = { "prettier" },
          typescript = { "prettier" },
          typescriptreact = { "prettier" },
          json = { "prettier" },
          css = { "prettier" },
          markdown = { "prettier" },
        },
      })
    end,
  },
  {
    "azratul/live-share.nvim",
    dependencies = { "jbyuki/instant.nvim" },
    lazy = false,                     -- Force the plugin to load at startup, not having this was posing issues earlier. so keep it that way
    config = function()
      vim.g.instant_username = "parv" -- pls Replace with your username
      require("live-share").setup({
        port_internal = 8765,         -- Local port for live share (dont change it might break)
        max_attempts = 40,            -- Number of retries to get the service URL
        service = "serveo.net",       -- Or "nokey@localhost.run" any works heheheha
      })
    end,
  },

  {
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    config = function()
      require("peek").setup()
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  }, {
  "Exafunction/codeium.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  config = function()
    require("codeium").setup({
    })
  end
},

  {
    "nvchad/ui",
    config = function()
      require "nvchad"
    end
  },
  { "nvzone/volt", lazy = true },

  {
    "nvzone/minty",
    cmd = { "Shades", "Huefy" },
  },
  {
    "nvchad/base46",
    lazy = true,
    build = function()
      require("base46").load_all_highlights()
    end,
  },
  { "nvzone/volt", lazy = true },
  { "nvzone/menu", lazy = true },
  "nvzone/volt", -- optional, needed for theme switcher
  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
