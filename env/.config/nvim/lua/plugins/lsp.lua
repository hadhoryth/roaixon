return {
    { 'mason-org/mason.nvim', lazy = false, opts = {} },
    require('plugins.lsp.completion'),
    require('plugins.lsp.config'),
    require('plugins.lsp.formatting'),
}
