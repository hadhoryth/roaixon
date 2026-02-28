return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('oil').setup({
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ['<C-h>'] = false, -- don't conflict with tmux
        ['<C-l>'] = false,
      },
    })
    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
  end,
}
