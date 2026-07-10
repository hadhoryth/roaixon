return {
    {
        'neovim/nvim-lspconfig',
        cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'mason-org/mason.nvim',
            'mason-org/mason-lspconfig.nvim',
        },
        init = function()
            -- Show the sign column (where icons for errors appear) by default
            vim.opt.signcolumn = 'yes'
        end,
        config = function()
            -- Completion capabilities for every server
            vim.lsp.config('*', {
                capabilities = require('cmp_nvim_lsp').default_capabilities(),
            })

            -- C/C++: Optimized Clangd
            vim.lsp.config('clangd', {
                cmd = {
                    'clangd',
                    '--background-index',
                    '--clang-tidy',
                    '--header-insertion=iwyu',
                    '--completion-style=detailed',
                    '--j=4',
                },
                -- utf-16 avoids "multiple different client offset_encodings"
                capabilities = { offsetEncoding = { 'utf-16' } },
                -- Disable formatting so it doesn't fight with Conform
                on_attach = function(client)
                    client.server_capabilities.documentFormattingProvider = false
                    client.server_capabilities.documentRangeFormattingProvider = false
                end,
            })

            -- Lua: Configured for Neovim development
            vim.lsp.config('lua_ls', {
                settings = {
                    Lua = {
                        diagnostics = { globals = { 'vim' } },
                        workspace = { checkThirdParty = false },
                    },
                },
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
                end,
            })

            -- Remove the 0.11 default gr-prefixed maps so bare gr stays instant
            for _, lhs in ipairs({ 'grr', 'grn', 'gra', 'gri', 'grt' }) do
                pcall(vim.keymap.del, 'n', lhs)
            end
            pcall(vim.keymap.del, 'x', 'gra')

            -- Mason installs the servers; mason-lspconfig v2 auto-enables them.
            -- clangd is skipped on Linux (installed via the distro instead) as
            -- mason has no aarch64 Linux build; it stays mason-managed on macOS.
            local ensure_installed = { 'lua_ls', 'ruff' }
            if vim.uv.os_uname().sysname ~= 'Linux' then
                table.insert(ensure_installed, 'clangd')
            end
            require('mason-lspconfig').setup({
                ensure_installed = ensure_installed,
            })
        end,
    },
}
