return {
  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        "                  gG88Pp                   ",
        "                 8888888b                  ",
        "                d888::::8b                 ",
        "G8888888888888  Y88888::8Y  88888888888888 ",
        " 88d8:::::::88   88888888'  88:::::::;88'  ",
        "   d88;;88::88    P8888P    88:;88:;88'    ",
        "    d88d88888888,   YY    ,888888888'      ",
        "              `p88888888889`               ",
        "       .d8888. `888888888'.d!!!!b          ",
        "         Y8888888.  YY   .d!!!!!!!b        ",
        "         ~d88888888.YY  y!!!!!!!!b'        ",
        "               `8888YYy!!!!!'              ",
        "                `888Y!!!!!'                ",
        "                 y!!!!!!!                  ",
        "               y!!!!!!!888a                ",
        "              y!!!!!YY~d888p               ",
        "             d!!!!! YY  88888              ",
        "             !!!!!C YY  9888p              ",
        "              ~d!!!aYYy9888y'              ",
        "               ~!!!!Y888889'               ",
        "                 .#8888889.                ",
        "              .8888888#!!!!.               ",
        "            .d88888 YY `!!!!!              ",
        "            Y88888' YY  `!!!!'             ",
        "           d88Y'    YY    `!!'             ",

        -- " █████  ███████ ████████ ██████   ██████",
        -- "██   ██ ██         ██    ██   ██ ██    ██",
        -- "███████ ███████    ██    ██████  ██    ██",
        -- "██   ██      ██    ██    ██   ██ ██    ██",
        -- "██   ██ ███████    ██    ██   ██  ██████",
        -- " ",
        -- "    ███    ██ ██    ██ ██ ███    ███",
        -- "    ████   ██ ██    ██ ██ ████  ████",
        -- "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
        -- "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
        -- "    ██   ████   ████   ██ ██      ██",
        --  [[                               __                ]],
        --
        -- [[   _______   _______  _______   ________   ________  _______              ]],
        -- [[  ╱╱   ╱   ╲╱╱       ╲╱       ╲╲╱    ╱   ╲ ╱        ╲╱       ╲╲           ]],
        -- [[ ╱╱        ╱╱        ╱        ╱╱         ╱_╱       ╱╱        ╱╱           ]],
        -- [[╱         ╱        _╱         ╱╲        ╱╱         ╱         ╱            ]],
        -- [[╲__╱_____╱╲________╱╲________╱  ╲╲_____╱ ╲╲_______╱╲__╱__╱__╱             ]],
        [[    _   ____________ _    ________  ___ ]],
        [[   / | / / ____/ __ \ |  / /  _/  |/  / ]],
        [[  /  |/ / __/ / / / / | / // // /|_/ /  ]],
        [[ / /|  / /___/ /_/ /| |/ // // /  / /   ]],
        [[/_/ |_/_____/\____/ |___/___/_/  /_/    ]],
        -- [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
        -- [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
        -- [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
        -- [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
        -- [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
        --
      }
      return opts
    end,
  },
  -- You can disable default plugins as follows:
  -- { "max397574/better-escape.nvim", enabled = false },
  --
  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  -- {
  --   "L3MON4D3/LuaSnip",
  --   config = function(plugin, opts)
  --     require "plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
  --     -- add more custom luasnip configuration such as filetype extend or custom snippets
  --     local luasnip = require "luasnip"
  --     luasnip.filetype_extend("javascript", { "javascriptreact" })
  --   end,
  -- },
  -- {
  --   "windwp/nvim-autopairs",
  --   config = function(plugin, opts)
  --     require "plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
  --     -- add more custom autopairs configuration such as custom rules
  --     local npairs = require "nvim-autopairs"
  --     local Rule = require "nvim-autopairs.rule"
  --     local cond = require "nvim-autopairs.conds"
  --     npairs.add_rules(
  --       {
  --         Rule("$", "$", { "tex", "latex" })
  --           -- don't add a pair if the next character is %
  --           :with_pair(cond.not_after_regex "%%")
  --           -- don't add a pair if  the previous character is xxx
  --           :with_pair(
  --             cond.not_before_regex("xxx", 3)
  --           )
  --           -- don't move right when repeat character
  --           :with_move(cond.none())
  --           -- don't delete if the next character is xx
  --           :with_del(cond.not_after_regex "xx")
  --           -- disable adding a newline when you press <cr>
  --           :with_cr(cond.none()),
  --       },
  --       -- disable for .vim files, but it work for another filetypes
  --       Rule("a", "a", "-vim")
  --     )
  --   end,
  -- },
  -- By adding to the which-key config and using our helper function you can add more which-key registered bindings
  -- {
  --   "folke/which-key.nvim",
  --   config = function(plugin, opts)
  --     require "plugins.configs.which-key"(plugin, opts) -- include the default astronvim config that calls the setup call
  --     -- Add bindings which show up as group name
  --     local wk = require "which-key"
  --     wk.register({
  --       b = { name = "Buffer" },
  --     }, { mode = "n", prefix = "<leader>" })
  --   end,
  -- },
}
