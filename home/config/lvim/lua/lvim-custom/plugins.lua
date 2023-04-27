local M = {}

M.setup = function()
  -- Additional Plugins
  lvim.plugins = {
    { "stevearc/dressing.nvim" },
    { "mattn/webapi-vim" },
    { "RRethy/nvim-base16" },
    { "tpope/vim-eunuch" }, -- :Move, :Delete, etc
    { "tpope/vim-rsi" }, -- Readline keybindings
    { "tpope/vim-fugitive" }, -- Git
    { "tpope/vim-surround" },
    { "tpope/vim-repeat" },

    -- Lots of things, including case changes
    -- See https://github.com/tpope/vim-abolish/blob/master/doc/abolish.txt
    { "tpope/vim-abolish" },

    -- Also lots of random things, mostly mappings that start with [ or ]
    -- See https://github.com/tpope/vim-unimpaired/blob/master/doc/unimpaired.txt
    { "tpope/vim-unimpaired" },

    { "vim-scripts/ReplaceWithRegister" },

    { "mrjones2014/legendary.nvim" },


    { "ggandor/leap.nvim" },
    { "jgdavey/vim-blockle" }, -- <leader>b to switch ruby block style
    { "vim-test/vim-test" },
    { "rgroli/other.nvim" },
    { "duane9/nvim-rg" },
    { "kevinhwang91/nvim-bqf" },
    { "amiel/neovim-tmux-navigator", build = "cargo install --path ." },
    { "folke/trouble.nvim", cmd = "TroubleToggle" },
    { "simrat39/rust-tools.nvim" },

    -- Syntax highlighting for kitty configs
    { "fladson/vim-kitty" },

    { "smjonas/live-command.nvim" },
    { "nvim-treesitter/nvim-treesitter-textobjects" },

    {
      "martineausimon/nvim-lilypond-suite",
      dependencies = { "MunifTanjim/nui.nvim" }
    },

    { "junegunn/goyo.vim" },

    { "Eandrju/cellular-automaton.nvim" },
  }


  require("leap").set_default_keymaps()

  require("live-command").setup({
    commands = {
      Norm = { cmd = "norm" },
      G = { cmd = "g" },
      Reg = {
        cmd = "norm",
        -- This will transform ":5Reg a" into ":norm 5@a"
        args = function(opts)
          return (opts.count == -1 and "" or opts.count) .. "@" .. opts.args
        end,
        range = "",
      },
    },
  })

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
        pattern = "/app/controllers/(.*)_controller.rb",
        target = "/spec/requests/%1_spec.rb",
      },
      {
        pattern = "/spec/requests/(.*)_spec.rb",
        target = "/app/controllers/%1_controller.rb",
      },
      {
        pattern = "/app/views/(.*)/(.*)",
        target = "/spec/views/%1/%2_spec.rb",
      },
      {
        pattern = "/spec/views/(.*)/(.*)_spec.rb",
        target = "/app/views/%1/%2",
      },
      {
        pattern = "/lib/(.*).rb",
        target = "/spec/lib/%1_spec.rb"
      },
      {
        pattern = "/spec/lib/(.*)_spec.rb",
        target = "/lib/%1.rb",
      },
    },
  })

  -- Supported by ruby:
  -- @block.inner
  -- @block.outer
  -- @class.inner
  -- @class.outer
  -- @function.inner
  -- @function.outer
  -- @parameter.inner
  -- @parameter.outer

  require("nvim-treesitter.configs").setup({
    textobjects = {
      select = {
        enable = true,

        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,

        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          -- You can optionally set descriptions to the mappings (used in the desc parameter of
          -- nvim_buf_set_keymap) which plugins like which-key display
          ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
          ["ab"] = "@block.outer",
          ["ib"] = "@block.inner",
        },
        -- You can choose the select mode (default is charwise 'v')
        --
        -- Can also be a function which gets passed a table with the keys
        -- * query_string: eg '@function.inner'
        -- * method: eg 'v' or 'o'
        -- and should return the mode ('v', 'V', or '<c-v>') or a table
        -- mapping query_strings to modes.
        selection_modes = {
          ['@parameter.outer'] = 'v', -- charwise
          ['@function.outer'] = 'V', -- linewise
          ['@class.outer'] = '<c-v>', -- blockwise
          ['@block.outer'] = 'v', -- blockwise
        },
      }
    }
  })



end

return M
