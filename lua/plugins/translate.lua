local keys = {
  {'m', desc = "translate"},
  {'mz', desc = "Translation from English to Chinese"},
  {'me', desc = "Translation from Chinese to English"},
}

for k, v in pairs {
  f = "-output=floating",
  s = "-output=split",
  i = "-output=insert",
  r = "-output=replace",
  c = "-comment",
} do
  vim.list_extend(keys, {
    { "mz" .. k, ("<Cmd>Translate ZH -source=EN %s<CR><Esc>"):format(v), mode = { "n", "x" }, desc = v },
    { "me" .. k, ("<Cmd>Translate EN -source=ZH %s<CR><Esc>"):format(v), mode = { "n", "x" }, desc = v },
  })
end

---@type LazySpec
return {
  {
    "uga-rosa/translate.nvim",
    keys = keys,
    config = function()
      require("translate").setup {

        default = {
          command = "deepl_free",
        },

        preset = {
          output = {
            split = {
              append = true,
            },
          },
        },
      }
    end,
  },
}
