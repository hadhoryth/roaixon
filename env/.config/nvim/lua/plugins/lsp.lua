return {
  { 'williamboman/mason.nvim', lazy = false, opts = {} },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
    },
    config = function()
      local cmp = require('cmp')

      cmp.setup({
        sources = {
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'path' },
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        }),
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },
      })
    end,
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
    init = function()
      vim.opt.signcolumn = 'yes'
    end,
    config = function()
      local lspconfig = require('lspconfig')
      local lsp_defaults = lspconfig.util.default_config

      -- Add cmp capabilities
      lsp_defaults.capabilities = vim.tbl_deep_extend(
        'force',
        lsp_defaults.capabilities,
        require('cmp_nvim_lsp').default_capabilities()
      )

      -- Keymaps on attach
      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
          local opts = { buffer = event.buf }

          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set({ 'n', 'x' }, '<leader>f', function()
            vim.lsp.buf.format({ async = true })
          end, opts)
        end,
      })

      -- Mason LSP setup
      require('mason-lspconfig').setup({
        ensure_installed = {
          'pyright',           -- Python
          'ts_ls',             -- TypeScript/JavaScript
          'bashls',            -- Bash
          'dockerls',          -- Dockerfile
          'docker_compose_language_service', -- docker-compose
          'jsonls',            -- JSON
          'taplo',             -- TOML
          'lua_ls',            -- Lua
        },
        handlers = {
          -- Default handler
          function(server_name)
            lspconfig[server_name].setup({})
          end,

          -- Python
          ['pyright'] = function()
            lspconfig.pyright.setup({
              settings = {
                python = {
                  analysis = {
                    typeCheckingMode = 'basic',
                    autoImportCompletions = true,
                  },
                },
              },
            })
          end,

          -- TypeScript
          ['ts_ls'] = function()
            lspconfig.ts_ls.setup({
              settings = {
                typescript = {
                  inlayHints = {
                    includeInlayParameterNameHints = 'all',
                    includeInlayVariableTypeHints = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                  },
                },
                javascript = {
                  inlayHints = {
                    includeInlayParameterNameHints = 'all',
                    includeInlayVariableTypeHints = true,
                  },
                },
              },
            })
          end,

          -- Lua (for neovim config)
          ['lua_ls'] = function()
            lspconfig.lua_ls.setup({
              settings = {
                Lua = {
                  runtime = { version = 'LuaJIT' },
                  diagnostics = { globals = { 'vim' } },
                  workspace = {
                    library = vim.api.nvim_get_runtime_file('', true),
                    checkThirdParty = false,
                  },
                  telemetry = { enable = false },
                },
              },
            })
          end,
        },
      })
    end,
  },
}
