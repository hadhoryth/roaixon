return {
    'nvim-treesitter/nvim-treesitter',
    -- Neovim 0.12 requires the rewritten API on main.
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
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
            'c',
            'cpp',
            'cmake',
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
    },
    config = function(_, opts)
        local treesitter = require('nvim-treesitter')
        treesitter.setup({})

        local function attach(buf, lang)
            if not vim.api.nvim_buf_is_valid(buf) or not vim.api.nvim_buf_is_loaded(buf) then
                return
            end
            local ft = vim.bo[buf].filetype
            if vim.treesitter.language.get_lang(ft) ~= lang then
                return
            end
            local stats = vim.uv.fs_stat(vim.api.nvim_buf_get_name(buf))
            if stats and stats.size > 100 * 1024 then
                vim.treesitter.stop(buf)
                return
            end
            vim.treesitter.start(buf, lang)
            if ft == 'markdown' then
                vim.bo[buf].syntax = 'markdown'
            end
            -- Treesitter indent misfires on incomplete C lines; keep native indentation.
            if ft ~= 'c' and ft ~= 'cpp' then
                vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end
        end

        local has_cli = vim.fn.executable('tree-sitter') == 1
        if has_cli then
            treesitter.install(opts.ensure_installed)
        else
            vim.notify('Parser installation requires tree-sitter CLI; run runs/50-neovim', vim.log.levels.WARN)
        end

        vim.api.nvim_create_autocmd('FileType', {
            group = vim.api.nvim_create_augroup('roaixon_treesitter', { clear = true }),
            -- Run after built-in ftplugins (Markdown starts its own highlighter in 0.12).
            callback = vim.schedule_wrap(function(event)
                local lang = vim.treesitter.language.get_lang(event.match)
                if not lang then
                    return
                end
                if vim.list_contains(treesitter.get_installed('parsers'), lang) then
                    attach(event.buf, lang)
                elseif has_cli and vim.list_contains(treesitter.get_available(), lang) then
                    treesitter.install({ lang }):await(vim.schedule_wrap(function(err, installed)
                        if not err and installed then
                            attach(event.buf, lang)
                        end
                    end))
                end
            end),
        })
    end,
}
