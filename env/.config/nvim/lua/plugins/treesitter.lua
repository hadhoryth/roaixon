return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {
    ensure_installed = {
      -- Core
      'vim',
      'vimdoc',
      'lua',
      'query',
      -- Languages you use
      'python',
      'typescript',
      'tsx',
      'javascript',
      'bash',
      -- Markup/Config
      'json',
      'toml',
      'yaml',
      'markdown',
      'markdown_inline',
      -- Docker
      'dockerfile',
      -- Web
      'html',
      'css',
    },
    auto_install = true,
    highlight = {
      enable = true,
      disable = function(_, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          vim.notify('Treesitter disabled for large file', vim.log.levels.WARN)
          return true
        end
      end,
      additional_vim_regex_highlighting = { 'markdown' },
    },
    indent = { enable = true },
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
  end,
}
