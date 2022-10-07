local M = {}

M.setup = function()
  -- Additional Plugins
  lvim.plugins = {
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

    { "ggandor/leap.nvim" },
    { "jgdavey/vim-blockle" }, -- <leader>b to switch ruby block style
    { "vim-test/vim-test" },
    { "rgroli/other.nvim" },
    { "duane9/nvim-rg" },
    { "kevinhwang91/nvim-bqf" },
    { "amiel/neovim-tmux-navigator", run = "cargo install --path ." },
    { "folke/trouble.nvim", cmd = "TroubleToggle" },
    { "simrat39/rust-tools.nvim" },

    -- Syntax highlighting for kitty configs
    { "fladson/vim-kitty" },

    -- { "melkster/modicator.nvim" },
    -- { "smjonas/live-command.nvim" },

    -- {
    --   'martineausimon/nvim-lilypond-suite',
    --   requires = { 'MunifTanjim/nui.nvim' }
    -- },
  }

  require('leap').set_default_keymaps()

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
end

return M
