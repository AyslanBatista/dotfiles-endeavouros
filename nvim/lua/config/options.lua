-- Manter configurações sensatas sem alterar comportamento básico do Vim
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Aparência
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.colorcolumn = "100"
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true

-- Indentação
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false

-- Busca
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Performance
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Clipboard e arquivos
vim.opt.clipboard = "unnamedplus"
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

-- Desativar spell check por padrão
vim.opt.spell = false

-- Configurações específicas por filetype
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lua", "json", "yaml", "html", "javascript", "typescript", "css" },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
  end,
})
