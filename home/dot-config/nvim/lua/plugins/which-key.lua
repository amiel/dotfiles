-- local mappings = dofile(os.getenv("HOME") .. "/.config/nvim/lua/which_key_mappings.lua")

-- print(vim.inspect(mappings))

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    icons = {
      separator = ">"
    }
  },
}
