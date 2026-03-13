return {
  "rgroli/other.nvim",
  config = function()
    require("other-nvim").setup({
      showMissingFiles = false,
      mappings = dofile(os.getenv("HOME") .. "/.config/nvim/lua/other_mappings.lua")
    })
  end
}
