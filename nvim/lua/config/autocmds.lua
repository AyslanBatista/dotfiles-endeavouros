-- Autocmds mínimos e úteis

-- Abrir Neotree apenas se não foi passado arquivo como argumento
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 then
      vim.cmd("Neotree show")
    end
  end,
})

-- Destacar ao copiar texto
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})
