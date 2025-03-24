-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  -- == Examples of Overriding Plugins ==

  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        "............................... ...::::..::::..:.::...:.::.::.........",
        "..............................   ...... ............:........:.:..:...",
        "........................... ..                 ....:.:..:.............",
        ".......................... . .                  .......:.....:........",
        "........................ ...  ..  ..                ..................",
        "...................... .                             .................",
        "......................                                ................",
        "...................         ........                  ................",
        "................         ...::::::........             ...............",
        "..................      .:::::::::::::....             ...............",
        ".......::.::.....       .................              ...............",
        ":.:...:::::..:...      .:...   .........    ..          ..............",
        ":..::.::.::.:..:.:.    :. ..     .......    .....      ...............",
        ":.:.::.:.....:.....    :.::  .  ......       ....       ..............",
        ":............:...:.   .::::.  ..:........     ..        ..............",
        "....:........:.:::. ...::::::.:::::.....     ..     . ................",
        ":...........::.::::..  :....::::::........  ..     ...................",
        ":...............::::..  .....................     ....................",
        ":........:.....::::::..   ....  ..............   .....................",
        ":....::.:.:..:..::..   .     ..............   .  . ...................",
        ":...:.::......::.                             ....   .................",
        ":.:::.::::::::::.                             ...     ................",
        ":::::::.:::::::::...      .                           ................",
        ":::::::::::.:::::.::.                                 ................",
        "::::::::::.::..:::.        .....                      ................",
        ":::::::::::...:::.        ......                 .....................",
        ":::::::::::::::::.     .   ......   ... ..............................",
        ":::::::::::::::::::..  ..              ..             ................",
        ":::::::::::::::::::..   ..                               ...........:.",
        "::::::::::::::::::.      ..                         .     ..........:.",
        ":::::::::::::::::.        ..   ....             .   ................:.",
        "::::::::::::::::::.         ..........              ...............::.",
        "::::::::::::::. :::.      .:............... ..      ................::",
        ":::::::::::::.   .............................     ...................",
        "::::::::::::.       ...............................................::.",
      }
      return opts
    end,
  },

  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = false },
  { "Civitasv/cmake-tools.nvim", enabled = false },
  { "jay-babu/mason-nvim-dap.nvim", enabled = false },
  
  {"CopilotC-Nvim/CopilotChat.nvim",
     opts = function(_, opts)
       opts.model = "claude-3.7-sonnet"
       return opts
     end,
   },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    keys = { ":", "/", "?" },
    dependencies = {
      "hrsh7th/cmp-cmdline",
    },
    config = function(_, opts)
      local cmp = require "cmp"
      cmp.setup(opts)

      local mapkey = {
        ["<C-j>"] = {
          c = function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end,
        },
        ["<C-k>"] = {
          c = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end,
        },
      }

      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(mapkey),
        sources = {
          { name = "buffer" },
        },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(mapkey),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          {
            name = "cmdline",
            options = {
              ignore_cmds = { "Man", "!" },
            },
          },
        }),
      })
    end,
  },
}
