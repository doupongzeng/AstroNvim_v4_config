-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 500, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = true, -- sets vim.opt.spell
        signcolumn = "auto", -- sets vim.opt.signcolumn to auto
        wrap = false, -- sets vim.opt.wrap
        scrolloff = 3,
        clipboard = "unnamedplus",
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
        -- clipboard = {
        --   name = "WslClipboard",
        --   copy = {
        --     ["+"] = "clip.exe",
        --     ["*"] = "clip.exe",
        --   },
        --   paste = {
        --     ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
        --     ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
        --   },
        --   cache_enabled = 0,
        -- },
        deepl_api_auth_key = os.getenv "DEEPL_API_AUTH_KEY",
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- navigate buffer tabs with `H` and `L`
        L = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        H = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- mappings seen under group name "Buffer"
        ["<Leader>bD"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Pick to close",
        },
        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        ["<Leader>b"] = { desc = "Buffers" },
        -- quick save
        -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
        ["<C-_>"] = {
          function() require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1) end,
          desc = "Toggle comment line",
        },
        ["<C-n>"] = { "<cmd>Neotree toggle<cr>", desc = "Toggle Explorer" },
        ["<leader>4"] = { "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch src/hdr" },
        ["<leader>tt"] = { "<cmd>ToggleTerm direction=float<cr>", desc = "ToggleTerm float default" },
        ["<leader>lH"] = {
          function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled {}) end,
          desc = "Toggle inlay_hint",
        },
        ["<M-'>"] = { '<Cmd>execute v:count . "ToggleTerm"<CR>', desc = "Toggle terminal" },
      },
      t = {
        -- setting a mapping to false will disable it
        -- ["<esc>"] = false,
        ["<M-'>"] = { "<Cmd>ToggleTerm<CR>", desc = "Toggle terminal" },
      },
      i = {
        ["<M-'>"] = { "<Esc><Cmd>ToggleTerm<CR>", desc = "Toggle terminal" },
      },
      v = {
        -- setting a mapping to false will disable it
        -- ["<esc>"] = false,
        ["<C-_>"] = {
          "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
          desc = "Toggle comment for selection",
        },
      },
    },
  },
}
