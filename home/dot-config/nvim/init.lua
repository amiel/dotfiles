-- I've tried to isolate calls into NeoVim's APIS below so that this part can
-- be vanilla Lua tables. Some additional configuration happens inside plugins
-- . Take a look at the files in lua/plugins/*.lua for more.
local global_options = {
  -- Disable network read/write for VimTree. I don't use it anyway.
  -- anyway.
  loaded_netrw = 1,
  loaded_netrwPlugin = 1,

  -- Use comma as the leader for keybindings
  mapleader = ","
}

local options = {
  -- Use system clipboard
  clipboard = "unnamed",

  -- Insert the configured number of spaces instead of a tab
  expandtab = true,

  -- Use Treesitter for folding
  foldexpr = "nvim_treesitter#foldexpr()",
  foldmethod = "expr",

  -- Use line numbers
  number = true,

  -- Treesitter will be set up for folding
  foldenable = false,

  -- The number of space characters inserted for indentation
  shiftwidth = 2,

  -- Indent automatically when starting a new line
  smartindent = true,

  -- Basically make spaces behave like tabs for code indentation
  smarttab = true,

  -- Open new splits to the bottom right
  splitbelow = true,
  splitright = true,

  -- How many spaces does a tab represent? This should be somewhat
  -- language-dependent but I primarily use Ruby so my default is 2.
  tabstop = 2

  -- I set this up ages ago and don't remember why, commenting out.
  -- wildmode = "longest,list:longest"
}

-- Some files don't get the right type assigned automatically, configure
-- them explicitly here.
local filetypes = {
  extension = {
    arb = "ruby"
  },
  filename = {
    Guardfile = "ruby"
  }
}

local keymaps_with_leader = {
  { keys = "t",  group = "tests",                                                                   desc = "+Tests" },
  { keys = "tn", cmd = "Neotest run",                                                               desc = "Run nearest test" },
  { keys = "ta", cmd = 'lua require("neotest").run.run(vim.fn.expand("%"))',                        desc = "Run all tests in file" },
  { keys = "ts", cmd = 'lua require("neotest").summary.toggle()',                                   desc = "Toggle neotest summary" },

  -- { keys = "b",  cmd = "Telescope buffers",                                                             desc = "Telescope buffers" },
  { keys = "h",  cmd = "Telescope find_files",                                                      desc = "Telescope find files" },

  { keys = "g",  group = "git",                                                                     desc = "+Git" },
  { keys = "gb", cmd = "Gitsigns blame_line",                                                       desc = "Git blame for line" },
  { keys = "gf", cmd = "Telescope git_files",                                                       desc = "Telescope Git files" },

  { keys = "l",  group = "lsp",                                                                     desc = "+LSP" },
  { keys = "lg", cmd = "Telescope live_grep",                                                       desc = "Telescope live grep" },
  { keys = "lr", cmd = "Telescope lsp_references",                                                  desc = "Telescope LSP References" },
  { keys = "ls", cmd = "Telescope lsp_document_symbols",                                            desc = "Telescope LSP doc symbols" },

  -- { keys = "n",  cmd = "set nonumber!",                                                                 desc = "Toggle line numbers" },

  { keys = "n",  group = "FindFiles",                                                               desc = "+Find Files" },
  { keys = "nh", cmd = "Telescope git_status",                                                      desc = "Git Status" },
  { keys = "nb", cmd = "Telescope buffers",                                                         desc = "Buffers" },
  { keys = "ne", cmd = "Telescope find_files cwd=%:h",                                              desc = "CWD" },


  { keys = "o",  group = "Other",                                                                   desc = "+Open Other" },
  { keys = "oo", cmd = "Other",                                                                     desc = "Open related file" },
  { keys = "os", cmd = "OtherSplit",                                                                desc = "Open related file in split" },
  { keys = "ov", cmd = "OtherVSplit",                                                               desc = "Open related file in vertical split" },

  { keys = ".",  group = "Other",                                                                   desc = "+Open Other" },
  { keys = "..", cmd = "Other",                                                                     desc = "Open related file" },
  { keys = ".-", cmd = "OtherSplit",                                                                desc = "Open related file in split" },
  { keys = ".|", cmd = "OtherVSplit",                                                               desc = "Open related file in vertical split" },

  { keys = "s",  cmd = "Telescope lsp_dynamic_workspace_symbols",                                   desc = "LSP symbols" },
  { keys = "x",  cmd = "lua vim.lsp.buf.format()",                                                  desc = "LSP Autoformat" },
  { keys = "/",  cmd = "nohlsearch",                                                                desc = "clear search hilight" },
  { keys = "|",  cmd = "vsplit",                                                                    desc = "Split Vertical" },
  { keys = "-",  cmd = "split",                                                                     desc = "Split Horizontal" },
  { keys = ",",  cmd = "e #",                                                                       desc = "Previous File" },

  { keys = "m",  group = "Macros",                                                                  desc = "+Macros" },
  { keys = "ml", cmd = "s/\\(\\w\\+\\) \\(||\\)\\?= \\(.*\\)$/let(:\\1) { \\3 }/",                  desc = "Promote to let" },
  { keys = "mf", cmd = "s/\\(\\w\\+\\) \\(||\\)\\?= \\(.*\\)$/def \\1\\r  \\3\\rend/",              desc = "Promote to function" },
  { keys = "mc", cmd = "s/\\(class\\|module\\) \\(\\w\\+\\)::\\(\\w\\+\\)/module \\2\\r  \\1 \\3/", desc = "Unnest module/class definition" }
  --
  --   l = { "<cmd>.s/\\(\\w\\+\\) \\(||\\)\\?= \\(.*\\)$/let(:\\1) { \\3 }/<cr>", "Promote to let" },
  --   f = { "<cmd>.s/\\(\\w\\+\\) \\(||\\)\\?= \\(.*\\)$/def \\1\\r  \\3\\rend/<cr>", "Promote to function" },
  --   c = {
  --     "<cmd>.s/\\(class\\|module\\) \\(\\w\\+\\)::\\(\\w\\+\\)/module \\2\\r  \\1 \\3/<cr>Goend<esc>",
  --     "Unnest module/class definition",
  --   },
  --   m = {
  --     function()
  --       vim.cmd([[
  --         echo "Testing"
  --       ]])
  --     end,
  --     "Testing"
  --   },
  -- }
  --
  --
}

-- TODO
vim.keymap.set("n", "<S-h>", ":tabp<cr>")
vim.keymap.set("n", "<S-l>", ":tabn<cr>")
vim.keymap.set("i", "<C-c>", "<ESC>")
vim.keymap.set("i", "<C-[>", "<C-c>")

vim.keymap.set("n", "K", ":RustLsp hover actions<cr>")

-- There's no more configuration after this comment, just setup.

-- Assign global configuration
for name, value in pairs(global_options) do
  vim.g[name] = value
end

-- Keymaps with leader
for _, t in ipairs(keymaps_with_leader) do
  if t["cmd"] then
    local keys = string.format("<leader>%s", t["keys"])
    local command = string.format("<cmd>%s<cr>", t["cmd"])

    vim.keymap.set("n", keys, command, { desc = t["desc"] })
  end
end

-- Assign main configuration
for name, value in pairs(options) do
  vim.opt[name] = value
end

vim.filetype.add(filetypes)


-- Use internal formatting for bindings like gq instead of LSP.
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.bo[args.buf].formatexpr = nil
  end
})

-- Load plugins using Lazy - https://github.com/folke/lazy.nvim
require("config.lazy")

-- Show Rubocop cop name in diagnostic output
vim.diagnostic.config({
  virtual_text = {
    format = function(diagnostic)
      return string.format("%s (%s %s)", diagnostic.message, diagnostic.source, diagnostic.code or "LSP")
    end
  }
})

-- Commenting for SQL files
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.sql" },
  command = "setl comments=:-- commentstring=--\\ %s"
})

-- Commenting for lilypond files
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.ly" },
  callback = function()
    vim.bo.commentstring = '%% %s'
  end,
})
