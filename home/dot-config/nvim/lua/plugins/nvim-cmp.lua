return {
  { "hrsh7th/cmp-nvim-lsp",                lazy = true },
  { "hrsh7th/cmp-nvim-lsp-signature-help" }, -- function signatures
  { "hrsh7th/cmp-nvim-lsp-document-symbol" }, -- symbols from the document in / searches
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },                    -- file names
  { "hrsh7th/cmp-cmdline" },                 -- vim : commands
  { "JMarkin/cmp-diag-codes" },              -- ie rubocop diag names
  { "hrsh7th/cmp-emoji" },                   -- emjoi starting with :
  { "uga-rosa/cmp-dictionary" },
  -- { "SergioRibera/cmp-dotenv" },             -- environment variables
  { "hrsh7th/cmp-nvim-lua" },                -- neovim lua api
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    config = function()
      require("crates").setup()
    end
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      { "rafamadriz/friendly-snippets" },
      { "saadparwaiz1/cmp_luasnip" }

    }
  },
  -- {
  --   "petertriho/cmp-git",
  --   dependencies = { "hrsh7th/nvim-cmp" },
  --   opts = {
  --     -- options go here
  --   },
  --   lazy = true,
  --   init = function()
  --     table.insert(require("cmp").get_config().sources, { name = "git" })
  --   end
  -- },
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        completion = {
          completeopt = "menu,menuone,preview,noselect"
        },
        -- completion.autocomplete
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
            -- vim.snippet.expand(args.body)
          end
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered()
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }) -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "nvim_lsp_signature_help" },
          { name = "buffer" },
          { name = "luasnip" },
          { name = "emoji" },

          {
            name = "diag-codes",
            -- default completion available only in comment context
            -- use false if you want to get in other context
            option = { in_comment = true }
          },

          { name = "nvim_lua" },
        }, {
          { name = "path" },
          {
            name = "dictionary",
            keyword_length = 2
          },
          -- { name = "dotenv" },
        })
      });

      local dict_paths = vim.tbl_filter(function(path)
        return vim.uv.fs_stat(path) ~= nil
      end, {
        "/usr/share/dict/words",
        "/opt/homebrew/Cellar/lilypond/2.24.4/share/lilypond/2.24.4/vim/syntax/lilypond-words",
      })

      require("cmp_dictionary").setup({
        paths = dict_paths,
      });

      --
      -- cmp.setup.cmdline({ "/", "?" }, {
      --   mapping = cmp.mapping.preset.cmdline(),
      --   sources = {
      --     { name = "nvim_lsp_document_symbol" },
      --     { name = "buffer" }
      --   }
      -- })
      --
      -- -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      -- cmp.setup.cmdline(":", {
      --   mapping = cmp.mapping.preset.cmdline(),
      --   sources = cmp.config.sources({
      --     { name = "path" }
      --   }, {
      --     { name = "cmdline" }
      --   }),
      --   matching = { disallow_symbol_nonprefix_matching = false }
      -- })
      --

      -- cmp.setup.filetype("gitcommit", {
      --   sources = cmp.config.sources({
      --     { name = "git" }
      --   }, {
      --     { name = "buffer" }
      --   })
      -- })
      -- require("cmp_git").setup()
    end,
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help"
    }
  }
}
