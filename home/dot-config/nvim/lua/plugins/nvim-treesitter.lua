return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "bash",
      "css",
      "csv",
      "html",
      "javascript",
      "json",
      "lua",
      "luadoc",
      "markdown",
      "ruby",
      "scss",
      "sql",
      "tmux",
      "yaml",
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = true,
    },
    indent = {
      disable = { "ruby" },
    },
  },
}
