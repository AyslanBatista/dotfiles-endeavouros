-- REGRA: Nunca remapear comandos básicos do Vim
-- Usar <leader> para funcionalidades extras

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- ============================================================================
-- NAVEGAÇÃO DE ARQUIVOS (usando <leader>)
-- ============================================================================
-- <leader>ff para find files
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })

-- <leader>fg para find text
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Find text in files" })

-- <leader>fr para find recent files
map("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Find recent files" })

-- <leader>fb para find buffers
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find buffers" })

-- <leader>e para file explorer
map("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Toggle file explorer" })

-- ============================================================================
-- COMANDOS ÚTEIS COM <leader>
-- ============================================================================
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
map("n", "<leader>x", "<cmd>x<CR>", { desc = "Save and quit" })

-- ============================================================================
-- LSP ACTIONS
-- ============================================================================
-- F2 para rename (padrão de muitos editores, não conflita com Vim)
map("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<CR>", { desc = "Rename symbol" })

-- <leader>ca para code actions
map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "Code actions" })

-- K para hover info (comando Vim nativo melhorado)
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { desc = "Show hover info" })

-- Nota: gd e gr são gerenciados pelo LazyVim (com Trouble integrado)
-- Não remapear aqui para não sobrescrever o comportamento melhorado

-- ============================================================================
-- NAVEGAÇÃO POR BUFFERS (Vim-friendly)
-- ============================================================================
map("n", "]b", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "[b", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>bd", "<cmd>bd<CR>", { desc = "Delete buffer" })

-- ============================================================================
-- TERMINAL (usando <leader>)
-- ============================================================================
map("n", "<leader>tt", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal" })
map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", { desc = "Float terminal" })

-- ESC para sair do terminal mode
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- ============================================================================
-- FORMATAÇÃO
-- ============================================================================
map("n", "<leader>fm", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", { desc = "Format document" })

-- ============================================================================
-- CLEAR SEARCH HIGHLIGHT
-- ============================================================================
map("n", "<leader>h", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- ============================================================================
-- SPLITS
-- ============================================================================
-- <leader>sv para split vertical
map("n", "<leader>sv", "<cmd>vsplit<CR>", { desc = "Split vertically" })

-- <leader>sh para split horizontal
map("n", "<leader>sh", "<cmd>split<CR>", { desc = "Split horizontally" })

-- Navegação nativa entre splits: Ctrl+w + h/j/k/l
-- Fechar split atual: Ctrl+w + c

-- ============================================================================
-- INLAY HINTS (Rust)
-- ============================================================================
map("n", "<leader>rh", function()
  vim.lsp.inlay_hint.enable(false, { bufnr = 0 })
  print("Inlay hints disabled")
end, { desc = "Disable inlay hints" })

map("n", "<leader>rH", function()
  vim.lsp.inlay_hint.enable(true, { bufnr = 0 })
  print("Inlay hints enabled")
end, { desc = "Enable inlay hints" })
