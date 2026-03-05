-- Autocmds mínimos e úteis

-- Destacar ao copiar texto
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

-- Forçar spell check desabilitado para todos os filetypes
-- (o LazyVim reativa spell para markdown/gitcommit por padrão)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.spell = false
  end,
})
