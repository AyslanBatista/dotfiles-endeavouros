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
-- <leader>ff para find files (ao invés de Ctrl+P)
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })

-- <leader>fg para find text (ao invés de Ctrl+F)
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Find text in files" })

-- <leader>fr para find recent files
map("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Find recent files" })

-- <leader>fb para find buffers
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find buffers" })

-- <leader>e para file explorer (ao invés de Ctrl+E)
map("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Toggle file explorer" })

-- ============================================================================
-- COMANDOS ÚTEIS COM <leader>
-- ============================================================================
-- <leader>w para salvar (alternativa ao :w)
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })

-- <leader>q para quit
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })

-- <leader>x para save and quit
map("n", "<leader>x", "<cmd>x<CR>", { desc = "Save and quit" })

-- ============================================================================
-- LSP ACTIONS (com teclas F ou <leader>)
-- ============================================================================
-- F2 para rename (padrão de muitos editores, não conflita com Vim)
map("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<CR>", { desc = "Rename symbol" })

-- gd para go to definition (comando Vim nativo melhorado)
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Go to definition" })

-- gr para show references (comando Vim nativo melhorado)  
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { desc = "Show references" })

-- <leader>ca para code actions
map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "Code actions" })

-- K para hover info (comando Vim nativo melhorado)
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { desc = "Show hover info" })

-- ============================================================================
-- NAVEGAÇÃO POR BUFFERS (Vim-friendly)
-- ============================================================================
-- ]b e [b para next/prev buffer (padrão de muitos plugins Vim)
map("n", "]b", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "[b", "<cmd>bprevious<CR>", { desc = "Previous buffer" })

-- <leader>bd para delete buffer
map("n", "<leader>bd", "<cmd>bd<CR>", { desc = "Delete buffer" })

-- ============================================================================
-- TERMINAL (usando <leader>)
-- ============================================================================
-- <leader>t para abrir terminal (ao invés de Ctrl+`)
map("n", "<leader>tt", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal" })
map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", { desc = "Float terminal" })

-- ESC para sair do terminal mode (padrão sensato)
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- ============================================================================
-- FORMATAÇÃO
-- ============================================================================
-- <leader>fm para format (ao invés de Shift+Alt+F)
map("n", "<leader>fm", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", { desc = "Format document" })

-- ============================================================================
-- CLEAR SEARCH HIGHLIGHT (útil e não conflita)
-- ============================================================================
map("n", "<leader>h", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- ============================================================================
-- SPLITS (melhorar comandos nativos)
-- ============================================================================
-- <leader>v para split vertical (melhora o :vsplit)
map("n", "<leader>v", "<cmd>vsplit<CR>", { desc = "Split vertically" })

-- <leader>s para split horizontal (melhora o :split)
map("n", "<leader>sv", "<cmd>split<CR>", { desc = "Split horizontally" })

-- Manter navegação nativa entre splits com Ctrl+w
-- (não remapear, apenas documentar)
-- Ctrl+w + h/j/k/l para navegar entre splits
-- Ctrl+w + c para fechar split atual
