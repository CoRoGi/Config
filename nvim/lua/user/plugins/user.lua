return {
  -- You can also add new plugins here as well:
  {
    "stevearc/oil.nvim",
    opts = {
      columns = {
        "icon",
        "permissions",
        "size",
        "mtime",
      }
    },
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  {
    "kdheepak/lazygit.nvim",
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {},
    event = "VeryLazy",
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    event = "VeryLazy",
  },

  {
    "tpope/vim-surround",
    config = function() end,
    event = "VeryLazy",
  },

  {
    "tpope/vim-repeat",
    config = function() end,
    event = "VeryLazy",
  },

  {
    "itchyny/calendar.vim",
    config = function() end,
    event = "VeryLazy",
    keys = {
      { "<C-g>", "<cmd>Calendar -task<cr>", desc = "Open Calendar" },
    },
  },

  {
    "vimwiki/vimwiki",
    event = "VeryLazy",
    keys = { "<leader>ww", "<leader>wt", { "<leader>v", "<cmd>Diary<cr>", desc = "Open Diary" } },
    init = function()
      vim.g.vimwiki_folding = ""
      vim.g.vimwiki_global_extension = 0
      vim.g.vimwiki_list = {
        {
          path = "~/Personal/Obsidian/",
          syntax = "markdown",
          ext = ".md",
        },
      }
    end,
  },

  {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    event = "VeryLazy",
    keys = {
      { "<leader>a", '<cmd>lua require("harpoon.mark").add_file()<cr>',        desc = "Add file to harpooon" },
      { "<C-e>",     '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', desc = "Toggle Quick Menu" },
      { "<C-h>",     '<cmd>lua require("harpoon.ui").nav_file(1)<cr>',         desc = "Jump to Mark 1" },
      { "<C-t>",     '<cmd>lua require("harpoon.ui").nav_file(2)<cr>',         desc = "Jump to Mark 2" },
      { "<C-n>",     '<cmd>lua require("harpoon.ui").nav_file(3)<cr>',         desc = "Jump to Mark 3" },
      { "<C-s>",     '<cmd>lua require("harpoon.ui").nav_file(4)<cr>',         desc = "Jump to Mark 4" },
    },
  },

  {
    "xiyaowong/transparent.nvim",
    config = {
      function()
        require("transparent").setup {
          groups = { -- table: default groups
            "Normal",
            "NormalNC",
            "Comment",
            "Constant",
            "Special",
            "Identifier",
            "Statement",
            "PreProc",
            "Type",
            "Underlined",
            "Todo",
            "String",
            "Function",
            "Conditional",
            "Repeat",
            "Operator",
            "Structure",
            "LineNr",
            "NonText",
            "SignColumn",
            "CursorLineNr",
            "TabLineFill",
            "TabLine",
            "EndOfBuffer",
            "NeoTreeNormal",
            "NormalFloat",
          },
          extra_groups = {
            "NormalFloat",   -- plugins which have float panel such as Lazy, Mason, LspInfo
            "NeoTreeNormal", -- NvimTree
            "NeoTree",
            "TabLineFill",
            "TabLine",
            "StatusLine",
          }, -- table: additional groups that should be cleared
          exclude_groups = {
            -- "Normal",
            -- "NormalNC",
            -- "Comment",
            -- "Constant",
            -- "Special",
            -- "Identifier",
            -- "Statement",
            -- "PreProc",
            -- "Type",
            -- "Underlined",
            -- "Todo",
            -- "String",
            -- "Function",
            -- "Conditional",
            -- "Repeat",
            -- "Operator",
            -- "Structure",
            -- "LineNr",
            -- "NonText",
            -- "EndOfBuffer",
            -- "NeoTreeNormal",
            -- "NormalFloat",
          }, -- table: groups you don't want to clear
        }
      end,
    },
    -- opts = {},
    lazy = false,
  },
}
