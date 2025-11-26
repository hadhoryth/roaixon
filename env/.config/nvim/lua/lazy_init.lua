local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  spec = {
    { import = 'plugins' },

    -- Theme
    {
      'catppuccin/nvim',
      name = 'catppuccin',
      priority = 1000,
      lazy = false,
      opts = {
        flavour = 'mocha',
        integrations = {
          gitsigns = true,
          mason = true,
          cmp = true,
          treesitter = true,
          telescope = { enabled = true },
        },
      },
      config = function(_, opts)
        require('catppuccin').setup(opts)
        vim.cmd.colorscheme('catppuccin')
      end,
    },
  },
  checker = { enabled = false },
  change_detection = { notify = false },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'matchit',
        'matchparen',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
})
