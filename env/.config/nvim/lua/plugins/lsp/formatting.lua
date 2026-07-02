return {
  {
    'stevearc/conform.nvim',
    event = { "BufWritePre" },
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
          prepend_args = { "-style={BasedOnStyle: google, ColumnLimit: 110}" },
        },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },
}
