local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.uv.fs_stat(lazypath) then
  local out = vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
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
