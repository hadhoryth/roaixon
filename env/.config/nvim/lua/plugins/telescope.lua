return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  cmd = 'Telescope',
  keys = {
    { '<leader>fd', '<cmd>Telescope find_files<cr>', desc = 'Find files' },
    { '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = 'Live grep' },
    { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'Buffers' },
    { '<leader>fh', '<cmd>Telescope help_tags<cr>', desc = 'Help' },
    { '<leader>fr', '<cmd>Telescope oldfiles<cr>', desc = 'Recent files' },
    { '<leader>fs', '<cmd>Telescope lsp_document_symbols<cr>', desc = 'Symbols' },
    { '<leader>fw', '<cmd>Telescope lsp_workspace_symbols<cr>', desc = 'Workspace symbols' },
    { '<leader>fl', '<cmd>Telescope current_buffer_fuzzy_find<cr>', desc = 'Search in file' },
    { '<leader>gc', '<cmd>Telescope git_commits<cr>', desc = 'Git commits' },
    { '<leader>gs', '<cmd>Telescope git_status<cr>', desc = 'Git status' },
  },
  config = function()
    local telescope = require('telescope')

    telescope.setup({
      defaults = {
        file_ignore_patterns = { 'node_modules', '.git/', '__pycache__', '%.pyc' },
        mappings = {
          i = {
            ['<C-j>'] = 'move_selection_next',
            ['<C-k>'] = 'move_selection_previous',
          },
        },
      },
      pickers = {
        find_files = {
          theme = 'ivy',
          hidden = true,
        },
        live_grep = {
          theme = 'ivy',
        },
        buffers = {
          theme = 'dropdown',
          previewer = false,
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
        },
      },
    })

    telescope.load_extension('fzf')

    -- Config editing shortcuts
    vim.keymap.set('n', '<leader>en', function()
      require('telescope.builtin').find_files({ cwd = vim.fn.stdpath('config') })
    end, { desc = 'Edit neovim config' })
  end,
}
