return {
  "stevearc/conform.nvim",
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { { "prettier" } },
        typescript = { { "prettier" } },
        json = { { "prettier" } },
        yaml = { { "prettier" } },
        markdown = { { "prettier" } },
        html = { { "prettier" } },
        css = { { "prettier" } },
        scss = { { "prettier" } },
        sass = { { "prettier" } },
        less = { { "prettier" } },
        vue = { { "prettier" } },
        typescriptreact = { { "prettier" } },
        javascriptreact = { { "prettier" } },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    })
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*",
      callback = function(args) require("conform").format({ bufnr = args.buf }) end,
    })
  end,
}
