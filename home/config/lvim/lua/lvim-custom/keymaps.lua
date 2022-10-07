local M = {}

M.setup = function()
  lvim.keys.normal_mode["<S-h>"] = ":tabp<cr>"
  lvim.keys.normal_mode["<S-l>"] = ":tabn<cr>"

  lvim.keys.insert_mode["<C-c>"] = "<ESC>"
  lvim.keys.insert_mode["<C-[>"] = "<C-c>"

  -- Use which-key to add extra bindings with the leader-key prefix

  -- lvim.builtin.which_key.mappings["t"] = {
  --   name = "+Trouble",
  --   r = { "<cmd>Trouble lsp_references<cr>", "References" },
  --   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  --   d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
  --   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  --   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  --   w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
  -- }



  lvim.builtin.which_key.mappings["/"] = { "<cmd>nohlsearch<CR>", "clear search hilight" }
  lvim.builtin.which_key.mappings["h"] = { "<cmd>Telescope find_files<CR>", "Find File" }
  lvim.builtin.which_key.mappings["v"] = { "<C-W>v", "Split Vertical" }
  lvim.builtin.which_key.mappings["w"] = { "<C-W>s", "Split Horizontal" }
  lvim.builtin.which_key.mappings[","] = { "<C-^>", "Previous File" }

  lvim.builtin.which_key.mappings["."] = {
    name = "+Open Other",
    ["."] = { "<cmd>Other<CR>", "Open Other" },
    v = { "<cmd>OtherVSplit<CR>", "Split Vertical" },
    w = { "<cmd>OtherSplit<CR>", "Split Horizontal" },
  }

  lvim.builtin.which_key.mappings["n"] = {
    name = "+Find File",
    h = { "<cmd>Telescope git_status<cr>", "Git Status" },
    b = { "<cmd>Telescope buffers<cr>", "Buffers" },
    e = { "<cmd>Telescope find_files cwd=%:h<cr>", "CWD" },
  }

  -- Macros
  lvim.builtin.which_key.mappings["m"] = {
    name = "+Macros",
    -- TODO: Refactor
    l = { "<cmd>.s/\\(\\w\\+\\) \\(||\\)\\?= \\(.*\\)$/let(:\\1) { \\3 }/<cr>", "Promote to let" },
    f = { "<cmd>.s/\\(\\w\\+\\) \\(||\\)\\?= \\(.*\\)$/def \\1\\r  \\3\\rend/<cr>", "Promote to function" },
    c = {
      "<cmd>.s/\\(class\\|module\\) \\(\\w\\+\\)::\\(\\w\\+\\)/module \\2\\r  \\1 \\3/<cr>Goend<esc>",
      "Unnest module/class definition"
    },
  }
end

return M
