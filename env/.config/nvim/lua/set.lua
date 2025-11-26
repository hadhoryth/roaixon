-- Line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- Tabs & indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- No wrap
vim.opt.wrap = false

-- No backup (use git)
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath('data') .. '/undodir'
vim.opt.undofile = true

-- Search
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Appearance
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.colorcolumn = '100'
vim.opt.cursorline = true

-- Performance
vim.opt.updatetime = 50
vim.opt.timeoutlen = 300

-- Split behavior
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Better completion
vim.opt.completeopt = 'menuone,noselect'

-- Allow project-local config
vim.opt.exrc = true

-- Filetypes
vim.filetype.add({
  extension = {
    tf = 'terraform',
    tfvars = 'terraform',
  },
  filename = {
    ['docker-compose.yml'] = 'yaml.docker-compose',
    ['docker-compose.yaml'] = 'yaml.docker-compose',
    ['Dockerfile'] = 'dockerfile',
  },
})
