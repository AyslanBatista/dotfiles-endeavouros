-- lua/config/options.lua
-- Configurações básicas do Neovim

-- Aparência
vim.opt.relativenumber = true -- Números de linha relativos
vim.opt.cursorline = true -- Destaca a linha atual do cursor
vim.opt.scrolloff = 8 -- Mantém o cursor 8 linhas distante do topo/fundo da tela
vim.opt.sidescrolloff = 8 -- Idem para rolagem horizontal
vim.opt.colorcolumn = "100" -- Coluna visual para limite de código
vim.opt.termguicolors = true -- Cores verdadeiras no terminal
vim.opt.conceallevel = 0 -- Mostra todos os caracteres sem ocultação
vim.opt.signcolumn = "yes" -- Sempre mostrar a coluna de sinais para diagnósticos

-- Desativar verificação ortográfica por padrão
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    vim.opt.spell = false
  end,
})
-- vim.opt.spelllang = "pt_br"

-- Configuração de indentação e quebra de linha
vim.opt.tabstop = 4 -- Tamanho do tab
vim.opt.softtabstop = 4 -- Espaços inseridos para tab
vim.opt.shiftwidth = 4 -- Espaços para indentação
vim.opt.expandtab = true -- Converte tabs em espaços
vim.opt.smartindent = true -- Indentação inteligente
vim.opt.wrap = false -- Não quebrar linhas longas

-- Configurações específicas para tipos de arquivo
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lua", "json", "yaml", "html", "javascript", "typescript", "css", "markdown" },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
  end,
})

-- Configurações específicas para Rust
vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
})

-- Busca melhorada
vim.opt.hlsearch = true -- Destaca resultados da busca
vim.opt.incsearch = true -- Busca incremental
vim.opt.ignorecase = true -- Busca sem diferenciar maiúsculas de minúsculas
vim.opt.smartcase = true -- Exceto quando há maiúsculas na busca

-- Configurações de terminal
vim.opt.shell = "/bin/zsh" -- Seu shell padrão

-- Configurações de desempenho
vim.opt.updatetime = 250 -- Atualização mais rápida para autocompletar
vim.opt.timeout = true
vim.opt.timeoutlen = 300 -- Tempo para reconhecer comandos

-- Configurações de estabilidade
vim.opt.hidden = true -- Permite trocar de buffer sem salvar
vim.opt.swapfile = false -- Desativa arquivos de swap
vim.opt.backup = false -- Desativa backup
vim.opt.undofile = true -- Histórico de desfazer persistente

-- Visualização de caracteres invisíveis (opcional, comente se não gostar)
vim.opt.list = true
vim.opt.listchars = {
  tab = "→ ",
  trail = "·",
  extends = "»",
  precedes = "«",
  nbsp = "␣",
}

-- Configurações para melhor integração com sistema de clipboard
vim.opt.clipboard = "unnamedplus" -- Usar clipboard do sistema
