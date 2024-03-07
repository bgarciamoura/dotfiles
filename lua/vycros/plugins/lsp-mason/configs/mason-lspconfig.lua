return {
  "williamboman/mason-lspconfig.nvim",
  config = function()
    local lspconfig = require("lspconfig")
    local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "tsserver",
        "cssls",
        "angularls",
        "eslint",
      },
      handlers = {
        function(server)
          lspconfig[server].setup({
            capabilities = lsp_capabilities,
          })
        end,
        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            capabilities = lsp_capabilities,
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" },
                },
              },
            },
          })
        end,
        ["tsserver"] = function()
          lspconfig.tsserver.setup({
            capabilities = lsp_capabilities,
            settings = {
              completions = {
                completeFunctionCalls = true,
              },
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          })
        end,
        ["eslint"] = function()
          lspconfig.eslint.setup({
            capabilities = lsp_capabilities,
            cmd = { "eslint_d", "--stdio" },
            filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
            root_dir = lspconfig.util.root_pattern(
              ".git",
              ".eslintrc",
              ".eslintrc.js",
              ".eslintrc.json",
              ".eslintrc.yaml",
              ".eslintrc.yml"
            ),
          })
        end,
        ["angularls"] = function()
          lspconfig.angularls.setup({
            capabilities = lsp_capabilities,
            cmd = { "ngserver", "--stdio" },
            filetypes = { "typescript", "typescriptreact", "html" },
            root_dir = lspconfig.util.root_pattern("angular.json", "tsconfig.json"),
          })
        end,
      },
    })
  end,
}
