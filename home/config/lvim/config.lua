--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.format_on_save = {
  pattern = "*",
  timeout = 8000,
}

lvim.colorscheme = "base16-material-darker"

-- TODO: Set up something for this:
-- https://www.reddit.com/r/neovim/comments/nrz9hp/can_i_close_all_floating_windows_without_closing/h0lg5m1/
-- or https://github.com/neovim/neovim/issues/11440#issuecomment-877693865

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = ","
-- add your own keymapping
lvim.keys.normal_mode["<S-h>"] = ":tabp<cr>"
lvim.keys.normal_mode["<S-l>"] = ":tabn<cr>"

lvim.keys.insert_mode["<C-c>"] = "<ESC>"
lvim.keys.insert_mode["<C-[>"] = "<C-c>"

-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = ""
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["w"] = { "<cmd>Telescope find_files<CR>", "Files" }
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

-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.terminal.active = true
lvim.builtin.bufferline.active = false
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0
lvim.builtin.telescope.defaults.sorting_strategy = "ascending"
lvim.builtin.telescope.defaults.layout_config.prompt_position = "top"

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "css",
  "rust",
  "ruby",
  "yaml",
}

lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---@usage Select which servers should be configured manually. Requires `:LvimCacheRest` to take effect.
-- See the full default list `:lua print(vim.inspect(lvim.lsp.override))`
-- vim.list_extend(lvim.lsp.override, { "pyright" })

-- ---@usage setup a server -- see: https://www.lunarvim.org/languages/#overriding-the-default-configuration
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pylsp", opts)

-- you can set a custom on_attach function that will be used for all the language servers
-- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end
-- you can overwrite the null_ls setup table (useful for setting the root_dir function)
-- lvim.lsp.null_ls.setup = {
--   root_dir = require("lspconfig").util.root_pattern("Makefile", ".git", "node_modules"),
-- }
-- or if you need something more advanced
-- lvim.lsp.null_ls.setup.root_dir = function(fname)
--   if vim.bo.filetype == "javascript" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "node_modules")(fname)
--       or require("lspconfig/util").path.dirname(fname)
--   elseif vim.bo.filetype == "php" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "composer.json")(fname) or vim.fn.getcwd()
--   else
--     return require("lspconfig/util").root_pattern("Makefile", ".git")(fname) or require("lspconfig/util").path.dirname(fname)
--   end
-- end

-- local rubocopdaemon = {
--     method = null_ls.methods.FORMATTING,
--     filetypes = { "ruby" },
--     -- null_ls.generator creates an async source
--     -- that spawns the command with the given arguments and options
--     generator = null_ls.generator({
--         command = "rubocop-daemon",
--         args = { "exec", "--", "--auto-correct", "-f", "quiet", "--stderr", "--stdin", "$FILENAME"},
--         to_stdin = true,
--         ignore_stderr = true,
--         -- choose an output format (raw, json, or line)
--         format = "raw",
--         check_exit_code = function(code, stderr)
--             local success = code <= 1

--       print("Checking exit code")
--       print("Checking exit code")
--       print("Checking exit code")
--       print("Checking exit code")

--             if not success then
--               -- can be noisy for things that run often (e.g. diagnostics), but can
--               -- be useful for things that run on demand (e.g. formatting)
--               print(stderr)
--             end

--             return success
--         end,
--     }),
-- }

-- local linters = require("lvim.lsp.null-ls.linters")
-- linters.setup({
--   { command = "rubocop" },
--   {
--     command = "shellcheck",
--     args = { "--severity", "warning" },
--   },
-- })

-- local h = require("null-ls.helpers")
-- local methods = require("null-ls.methods")

-- local FORMATTING = methods.internal.FORMATTING

-- local rubocopdaemon = h.make_builtin({
--   name = "rubocop-daemon",
--   method = FORMATTING,
--   filetypes = { "ruby" },
--   factory = h.generator_factory,
--   generator_opts = {
--     command = "rubocop-daemon",
--     args = {
--       "exec",
--       "--",
--       "--autocorrect",
--       "--format=quiet",
--       "--stderr",
--       "--out=/dev/null",
--       "--stdin=$FILENAME",
--     },
--     to_stdin = true,
--     ignore_stderr = true,
--     on_output = function(params, done)
--       local output = params.output
--       if not output then
--         return done()
--       end

--       local result = output:gsub("^====================\n", "")

--       return done({ { text = result } })
--     end,
--   },
-- })

-- local null_ls = require("null-ls")
-- -- null_ls.register(rubocopdaemon)
-- local sources = { rubocopdaemon, null_ls.builtins.formatting.stylua }
-- null_ls.setup({ sources = sources })

-- local sources = {rubocopdaemon}
-- null_ls.setup({ sources = sources })

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--    { exe = "rubocop", filetypes = { "ruby" } },
-- }

-- formatters.setup {
--   { command = "rufo", filetypes = { "ruby"}}
-- }
--   { exe = "rubocop-daemon", args = { "exec", "--", "--auto-correct", "-f", "quiet", "--stderr", "--stdin", "$FILENAME",}, filetypes = { "ruby" } },
--   -- {
--   --   exe = "prettier",
--   --   ---@usage arguments to pass to the formatter
--   --   -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--   --   args = { "--print-with", "100" },
--   --   ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--   --   -- filetypes = { "typescript", "typescriptreact" },
--   -- },
-- }

-- local null_ls = require("null-ls")

-- -- register any number of sources simultaneously
-- local sources = {
--     null_ls.builtins.formatting.prettier,
--     null_ls.builtins.diagnostics.write_good,
--     null_ls.builtins.code_actions.gitsigns,
-- }

-- null_ls.setup({ sources = sources })

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { exe = "flake8", filetypes = { "python" } },
--   {
--     exe = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     args = { "--severity", "warning" },
--   },
--   {
--     exe = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

-- Additional Plugins
lvim.plugins = {
  { "mattn/webapi-vim" },
  { "RRethy/nvim-base16" },
  { "tpope/vim-eunuch" }, -- :Move, :Delete, etc
  { "tpope/vim-rsi" }, -- Readline keybindings
  { "tpope/vim-fugitive" }, -- Git
  { "tpope/vim-abolish" }, -- Lots of things, including case changes
  { "jgdavey/vim-blockle" }, -- <leader>b to switch ruby block style
  { "vim-test/vim-test" },
  { "rgroli/other.nvim" },
  { "duane9/nvim-rg" },
  { "kevinhwang91/nvim-bqf" },
  { "amiel/neovim-tmux-navigator", run = "cargo install --path ." },
  { "folke/trouble.nvim", cmd = "TroubleToggle" },
  { "simrat39/rust-tools.nvim" },
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }

require("other-nvim").setup({
  mappings = {
    {
      pattern = "/app/(.*)/(.*).rb",
      target = "/spec/%1/%2_spec.rb",
    },
    {
      pattern = "/spec/(.*)/(.*)_spec.rb",
      target = "/app/%1/%2.rb",
    },
    {
      pattern = "/app/controllers/api/v1/(.*)_controller.rb",
      target = "/spec/requests/api/v1/%1_request_spec.rb",
    },
    {
      pattern = "/spec/requests/api/v1/(.*)_request_spec.rb",
      target = "/app/controllers/api/v1/%1_controller.rb",
    },
  },
})
