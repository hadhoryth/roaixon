vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- File explorer (netrw fallback, oil preferred via `-`)
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex, { desc = 'Open netrw' })

-- Paste without losing register
vim.keymap.set('x', '<leader>p', [["_dP]], { desc = 'Paste without yank' })

-- Yank to system clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'Yank to clipboard' })
vim.keymap.set('n', '<leader>Y', [["+Y]], { desc = 'Yank line to clipboard' })

-- Delete to void register
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]], { desc = 'Delete to void' })

-- Better movement
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Half page down centered' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Half page up centered' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search centered' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Prev search centered' })

-- Move lines in visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move line down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move line up' })

-- Keep cursor position on J
vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'Join lines keep cursor' })

-- Quick save
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = 'Save file', silent = true })

-- Clear search highlight
vim.keymap.set('n', '<Esc>', ':noh<CR>', { desc = 'Clear highlights', silent = true })

-- Quickfix navigation
vim.keymap.set('n', '<C-j>', ':cnext<CR>zz', { desc = 'Next quickfix', silent = true })
vim.keymap.set('n', '<C-k>', ':cprev<CR>zz', { desc = 'Prev quickfix', silent = true })

-- Search and replace word under cursor
vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Replace word' })


-- ==========================================
-- BUILT-IN TERMINAL SETUP
-- ==========================================

-- 1. Open a terminal at the bottom with <leader>t
vim.keymap.set('n', '<leader>t', ':botright split | resize 15 | term<CR>A', {
    noremap = true,
    silent = true,
    desc = 'Open Terminal'
})

vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', {
    noremap = true,
    silent = true,
    desc = 'Exit terminal mode'
})
