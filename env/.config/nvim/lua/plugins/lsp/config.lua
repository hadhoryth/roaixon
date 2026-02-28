return {
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
            -- Show the sign column (where icons for errors appear) by default
            vim.opt.signcolumn = 'yes'
        end,
        config = function()
            local lspconfig = require('lspconfig')
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            -- Fix for clangd "multiple different client offset_encodings" warning
            local clangd_capabilities = vim.tbl_deep_extend('force', capabilities, {
                offsetEncoding = { 'utf-16' },
            })

            -- Keymaps: Only active when an LSP is attached to a buffer
            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'LSP actions',
                callback = function(event)
                    local opts = { buffer = event.buf }

                    -- Navigation & Info
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

                    -- Actions
                    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
                    vim.keymap.set({ 'n', 'x' }, '<leader>ca', vim.lsp.buf.code_action, opts)

                    -- Formatting (Using Conform.nvim)
                    vim.keymap.set({ 'n', 'x' }, '<leader>f', function()
                        require("conform").format({ async = true, lsp_fallback = true })
                    end, opts)
                end,
            })

            require('mason-lspconfig').setup({
                ensure_installed = {
                    'pyright', 'ruff', 'bashls',
                    'dockerls', 'jsonls', 'lua_ls', 'clangd'
                },
                handlers = {
                    -- Default handler for all servers
                    function(server_name)
                        lspconfig[server_name].setup({ capabilities = capabilities })
                    end,

                    -- Python: Pyright (Logic) + Ruff (Linting/Style)
                    ['pyright'] = function()
                        lspconfig.pyright.setup({
                            capabilities = capabilities,
                            settings = {
                                pyright = { disableOrganizeImports = true },
                                python = { analysis = { ignore = { '*' }, typeCheckingMode = 'basic' } },
                            },
                        })
                    end,

                    -- C/C++: Optimized Clangd
                    ['clangd'] = function()
                        lspconfig.clangd.setup({
                            capabilities = clangd_capabilities,
                            cmd = {
                                'clangd',
                                '--background-index',
                                '--clang-tidy',
                                '--header-insertion=iwyu',
                                '--completion-style=detailed',
                                '--j=4',
                            },
                            -- Disable formatting so it doesn't fight with Conform
                            on_attach = function(client)
                                client.server_capabilities.documentFormattingProvider = false
                                client.server_capabilities.documentRangeFormattingProvider = false
                            end,
                        })
                    end,

                    -- Lua: Configured for Neovim development
                    ['lua_ls'] = function()
                        lspconfig.lua_ls.setup({
                            capabilities = capabilities,
                            settings = {
                                Lua = {
                                    diagnostics = { globals = { 'vim' } },
                                    workspace = { checkThirdParty = false },
                                },
                            },
                        })
                    end,
                },
            })
        end,
    },
}
