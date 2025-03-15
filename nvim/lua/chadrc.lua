-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "chadracula",
  transparency = true,
  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
}
M.nvdash = {

  load_on_startup = true,

  header =
  {
    [[                                                                       ]],
    [[                                                                     ]],
    [[       ████ ██████           █████      ██                     ]],
    [[      ███████████             █████                             ]],
    [[      █████████ ███████████████████ ███   ███████████   ]],
    [[     █████████  ███    █████████████ █████ ██████████████   ]],
    [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
    [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
    [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
    [[                                                                       ]],
  }

  -- buttons = {
  --   { txt = "  Find File", keys = "Spc f f", cmd = "Telescope find_files" },
  --   { txt = "󰈚  Recent Files", keys = "Spc f o", cmd = "Telescope oldfiles" },
  --   { txt = "󰈭  Find Word", keys = "Spc f w", cmd = "Telescope live_grep" },
  --   { txt = "  Bookmarks", keys = "Spc m a", cmd = "Telescope marks" },
  --   { txt = "  Themes", keys = "Spc t h", cmd = "Telescope themes" },
  --   { txt = "  Mappings", keys = "Spc c h", cmd = "NvCheatsheet" },
  -- },

}
M.ui = {
  statusline = {
    theme = "default",
    separator_style = "arrow",
    order = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cwd", "cursor" },
    modules = {
      abc = function()
        return "hi"
      end,

      xyz = "hi",
      f = "%F"
    }
  },

  tabufline = {
    order = { "treeOffset", "buffers", "tabs", "abc" },
    modules = {
      abc = function()
        return "💀"
      end,
    }
  },
  cmp = {

    lspkind_text = true,
    style = "default", -- default/flat_light/flat_dark/atom/atom_colored
    format_colors = {
      tailwind = true,
    },

    statusline = {
      theme = "vscode",
      separator_style = "vscode",
      order = { "mode", "f", "git", "%=", "lsp_msg", "%=", "lsp", "cwd", "xyz", "abc" },
      modules = {
        abc = function()
          return "hi"
        end,

        xyz = "hi",
        f = "%F"
      }
    },
  },


}
M.term = {
  winopts = { number = false },
  sizes = { sp = 0.3, vsp = 0.2, ["bo sp"] = 0.3, ["bo vsp"] = 0.2 },
  float = {
    relative = "editor",
    row = 0.3,
    col = 0.25,
    width = 0.5,
    height = 0.4,
    border = "single",
  },
}

M.colorify = {
  enabled = true,
  mode = "virtual", -- fg, bg, virtual
  virt_text = "󱓻 ",
  highlight = { hex = true, lspvars = true },
}

vim.api.nvim_set_hl(0, "CmpItemKindSupermaven", { fg = "#6CC644" })
return M
