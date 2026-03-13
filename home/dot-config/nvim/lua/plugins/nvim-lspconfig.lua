return {
  "neovim/nvim-lspconfig",
  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    vim.lsp.config("bashls", {
      capabilities = capabilities
    })

    vim.lsp.config("ruby_lsp", {
      cmd = { "bundle", "exec", "ruby-lsp" },
      init_options = {
        formatter = "rubocop_internal",
        linters = { "rubocop_internal" }
      },
      capabilities = capabilities
    })

    vim.lsp.config("eslint", {
      capabilities = capabilities
    })

    vim.lsp.config("html", {
      capabilities = capabilities
    })

    vim.lsp.config("cssls", {
      capabilities = capabilities
    })

    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
      on_init = function(client)
        local path = client.workspace_folders[1].name
        if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
          return
        end

        client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
          runtime = {},
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME
            }
          }
        })
      end,
      settings = {
        Lua = {
          format = {
            enable = true,
            defaultConfig = {
              indent_style = "space",
              indent_size = "2",
              quote_style = "double",
              trailing_table_separator = "never"
            }
          }
        }
      }
    })

    vim.lsp.enable({
      "bashls",
      "ruby_lsp",
      "eslint",
      "html",
      "cssls",
      "lua_ls"
    })
  end
}
