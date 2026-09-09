return {
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = { 'mason-org/mason.nvim' },
    event = 'VeryLazy',
    opts = {
      ensure_installed = { 'stylua', 'clang-format' },
    },
  },
  {
    'stevearc/conform.nvim',
    event = { "BufWritePre" },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format({ async = true, lsp_fallback = true })
        end,
        mode = { 'n', 'x' },
        desc = 'Format buffer',
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff_organize_imports", "ruff_format" },
        c = { "clang-format" },
        cpp = { "clang-format" },
      },
      formatters = {
        stylua = {
          prepend_args = { "--column-width", "110" },
        },
        ruff_format = {
          prepend_args = { "--line-length", "110" },
        },
        ["clang-format"] = {
          prepend_args = { "-style={BasedOnStyle: google, ColumnLimit: 110, IndentWidth: 4}" },
        },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },
}
