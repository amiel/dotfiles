local M = {}

M.setup = function()
  require("lvim-custom.plugins").setup()
  require("lvim-custom.keymaps").setup()
end

return M
