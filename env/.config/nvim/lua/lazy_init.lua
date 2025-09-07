local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)


require("lazy").setup({
  spec = {
    { import = "plugins" },

    -- Theme plugin
    {
      "catppuccin/nvim",
      name = "catppuccin",
      priority = 1000,
      lazy = false, -- ensure it loads at startup
      opts = {
        flavour = "mocha", -- optional
        custom_highlights = function(colors)
          return {
            -- Python import keyword (Treesitter group)
            ["@module"] = { style = { "bold" } },
          }
        end,
      },
      config = function(_, opts)
        require("catppuccin").setup(opts)
        vim.cmd.colorscheme("catppuccin")
      end,
    },
  },
  checker = { enabled = true },
})
