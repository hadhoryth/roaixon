return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function()
    local telescope = require("telescope")
    local builtin = require("telescope.builtin")

    telescope.setup({
      pickers = {
        find_files = { theme = "ivy" },
      },
      extensions = {
        fzf = {},
      },
    })

    telescope.load_extension("fzf")

    vim.keymap.set("n", "<space>fh", builtin.help_tags)
    vim.keymap.set("n", "<space>fd", builtin.find_files)
    vim.keymap.set("n", "<space>en", function()
      builtin.find_files({ cwd = vim.fn.stdpath("config")})
    end)
    vim.keymap.set("n", "<space>ep", function()
      builtin.find_files({
        cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy"),
      })
    end)
    vim.keymap.set("n", "<space>fg", builtin.live_grep)              -- search text in project
    vim.keymap.set("n", "<space>fs", builtin.lsp_document_symbols)   -- search symbols in current file
    vim.keymap.set("n", "<space>fw", builtin.lsp_workspace_symbols)  -- search symbols in workspace
    vim.keymap.set("n", "<space>fb", builtin.buffers)                -- search open buffers
    vim.keymap.set("n", "<space>fl", builtin.current_buffer_fuzzy_find) -- search inside current file
  end,
}
