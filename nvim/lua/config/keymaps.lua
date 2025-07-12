-- keymaps.lua
-- Atalhos de teclado no estilo VSCode para LazyVim

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- ============================================================================
-- TERMINAL (estilo VSCode)
-- ============================================================================
-- CTRL+SHIFT+` para toggle terminal (como no VSCode)
map("n", "<C-S-`>", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal (VSCode style)" })
map("t", "<C-S-`>", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal from terminal mode" })

-- Alternativa com CTRL+J (caso CTRL+SHIFT+` não funcione no seu terminal)
map("n", "<C-j>", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal (alternative)" })
map("t", "<C-j>", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal from terminal mode" })

-- Sair do modo terminal com ESC
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- ============================================================================
-- COMENTÁRIOS (estilo VSCode)
-- ============================================================================
-- CTRL+; para comentar/descomentar linha atual
map("n", "<C-;>", function()
  require("Comment.api").toggle.linewise.current()
end, { desc = "Toggle comment line" })

-- CTRL+; para comentar/descomentar seleção em modo visual
map("v", "<C-;>", function()
  local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
  vim.api.nvim_feedkeys(esc, "nx", false)
  require("Comment.api").toggle.linewise(vim.fn.visualmode())
end, { desc = "Toggle comment selection" })

-- CTRL+SHIFT+A para comentário em bloco (como no VSCode)
map("n", "<C-S-a>", function()
  require("Comment.api").toggle.blockwise.current()
end, { desc = "Toggle block comment" })

map("v", "<C-S-a>", function()
  local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
  vim.api.nvim_feedkeys(esc, "nx", false)
  require("Comment.api").toggle.blockwise(vim.fn.visualmode())
end, { desc = "Toggle block comment selection" })

-- ============================================================================
-- NAVEGAÇÃO DE ARQUIVOS (estilo VSCode)
-- ============================================================================
-- CTRL+P para buscar arquivos
map("n", "<C-p>", "<cmd>Telescope find_files<CR>", { desc = "Find files" })

-- CTRL+SHIFT+P para command palette
map("n", "<C-S-p>", "<cmd>Telescope commands<CR>", { desc = "Command palette" })

-- CTRL+F para buscar texto
map("n", "<C-f>", "<cmd>Telescope live_grep<CR>", { desc = "Find text in files" })

-- CTRL+E para toggle file explorer
map("n", "<C-e>", "<cmd>Neotree toggle<CR>", { desc = "Toggle file explorer" })

-- ============================================================================
-- EDITOR ACTIONS (estilo VSCode)
-- ============================================================================
-- CTRL+S para salvar
map("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
map("i", "<C-s>", "<Esc><cmd>w<CR>", { desc = "Save file from insert mode" })

-- CTRL+SHIFT+S para salvar como
map("n", "<C-S-s>", "<cmd>w ", { desc = "Save as..." })

-- CTRL+W para fechar buffer/aba
map("n", "<C-w>", "<cmd>bd<CR>", { desc = "Close buffer" })

-- CTRL+SHIFT+W para fechar janela
map("n", "<C-S-w>", "<cmd>close<CR>", { desc = "Close window" })

-- CTRL+N para novo arquivo
map("n", "<C-n>", "<cmd>enew<CR>", { desc = "New file" })

-- CTRL+O para abrir arquivo
map("n", "<C-o>", "<cmd>Telescope find_files<CR>", { desc = "Open file" })

-- ============================================================================
-- NAVEGAÇÃO POR TABS/BUFFERS (estilo VSCode)
-- ============================================================================
-- CTRL+TAB para próximo buffer
map("n", "<C-Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })

-- CTRL+SHIFT+TAB para buffer anterior
map("n", "<C-S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })

-- ALT+1-9 para ir para buffer específico
for i = 1, 9 do
  map("n", "<A-" .. i .. ">", "<cmd>BufferLineGoToBuffer " .. i .. "<CR>", { desc = "Go to buffer " .. i })
end

-- ============================================================================
-- EDIÇÃO DE TEXTO (estilo VSCode)
-- ============================================================================
-- ALT+UP/DOWN para mover linhas
map("n", "<A-Up>", "<cmd>m .-2<CR>==", { desc = "Move line up" })
map("n", "<A-Down>", "<cmd>m .+1<CR>==", { desc = "Move line down" })
map("v", "<A-Up>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
map("v", "<A-Down>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })

-- CTRL+D para duplicar linha
map("n", "<C-d>", "<cmd>t.<CR>", { desc = "Duplicate line" })
map("v", "<C-d>", "y'>pgv", { desc = "Duplicate selection" })

-- CTRL+L para selecionar linha inteira
map("n", "<C-l>", "V", { desc = "Select line" })

-- CTRL+SHIFT+K para deletar linha
map("n", "<C-S-k>", "dd", { desc = "Delete line" })

-- CTRL+SHIFT+D para duplicar seleção
map("v", "<C-S-d>", "y'>p", { desc = "Duplicate selection" })

-- ============================================================================
-- BUSCA E SUBSTITUIÇÃO (estilo VSCode)
-- ============================================================================
-- CTRL+F para busca local (dentro do arquivo)
map("n", "<C-f>", "/", { desc = "Search in file" })

-- CTRL+H para busca e substituição
map("n", "<C-h>", "<cmd>lua require('spectre').open()<CR>", { desc = "Search and replace" })

-- F3 para próximo resultado da busca
map("n", "<F3>", "n", { desc = "Next search result" })

-- SHIFT+F3 para resultado anterior da busca
map("n", "<S-F3>", "N", { desc = "Previous search result" })

-- ============================================================================
-- CODE ACTIONS E LSP (estilo VSCode)
-- ============================================================================
-- CTRL+SPACE para code actions
map("n", "<C-Space>", "<cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "Code actions" })
map("v", "<C-Space>", "<cmd>lua vim.lsp.buf.range_code_action()<CR>", { desc = "Code actions" })

-- F2 para rename
map("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<CR>", { desc = "Rename symbol" })

-- CTRL+SHIFT+O para ir para símbolo
map("n", "<C-S-o>", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "Go to symbol" })

-- F12 para ir para definição
map("n", "<F12>", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Go to definition" })

-- CTRL+F12 para ir para implementação
map("n", "<C-F12>", "<cmd>lua vim.lsp.buf.implementation()<CR>", { desc = "Go to implementation" })

-- SHIFT+F12 para ver todas as referências
map("n", "<S-F12>", "<cmd>lua vim.lsp.buf.references()<CR>", { desc = "Show references" })

-- CTRL+K CTRL+I para hover info
map("n", "<C-k><C-i>", "<cmd>lua vim.lsp.buf.hover()<CR>", { desc = "Show hover info" })

-- CTRL+SHIFT+SPACE para signature help
map("n", "<C-S-Space>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { desc = "Signature help" })
map("i", "<C-S-Space>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { desc = "Signature help" })

-- ============================================================================
-- DEBUGGING (estilo VSCode)
-- ============================================================================
-- F5 para start/continue debugging
map("n", "<F5>", "<cmd>lua require'dap'.continue()<CR>", { desc = "Debug: Start/Continue" })

-- F9 para toggle breakpoint
map("n", "<F9>", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { desc = "Debug: Toggle Breakpoint" })

-- F10 para step over
map("n", "<F10>", "<cmd>lua require'dap'.step_over()<CR>", { desc = "Debug: Step Over" })

-- F11 para step into
map("n", "<F11>", "<cmd>lua require'dap'.step_into()<CR>", { desc = "Debug: Step Into" })

-- SHIFT+F11 para step out
map("n", "<S-F11>", "<cmd>lua require'dap'.step_out()<CR>", { desc = "Debug: Step Out" })

-- SHIFT+F5 para stop debugging
map("n", "<S-F5>", "<cmd>lua require'dap'.terminate()<CR>", { desc = "Debug: Stop" })

-- CTRL+SHIFT+F5 para restart debugging
map("n", "<C-S-F5>", "<cmd>lua require'dap'.restart()<CR>", { desc = "Debug: Restart" })

-- ============================================================================
-- SPLITS E JANELAS (estilo VSCode)
-- ============================================================================
-- CTRL+\ para split vertical
map("n", "<C-\\>", "<cmd>vsplit<CR>", { desc = "Split vertically" })

-- CTRL+SHIFT+\ para split horizontal
map("n", "<C-S-\\>", "<cmd>split<CR>", { desc = "Split horizontally" })

-- CTRL+W para fechar split atual
map("n", "<C-w>", "<C-w>c", { desc = "Close split" })

-- ALT+ARROW para navegar entre splits
map("n", "<A-Left>", "<C-w>h", { desc = "Go to left split" })
map("n", "<A-Right>", "<C-w>l", { desc = "Go to right split" })
map("n", "<A-Up>", "<C-w>k", { desc = "Go to upper split" })
map("n", "<A-Down>", "<C-w>j", { desc = "Go to lower split" })

-- ============================================================================
-- FORMATAÇÃO (estilo VSCode)
-- ============================================================================
-- SHIFT+ALT+F para formatar documento
map("n", "<S-A-f>", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", { desc = "Format document" })
map("v", "<S-A-f>", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", { desc = "Format selection" })

-- CTRL+K CTRL+F para formatar seleção
map("v", "<C-k><C-f>", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", { desc = "Format selection" })

-- ============================================================================
-- ZOOM/FONT SIZE (estilo VSCode)
-- ============================================================================
-- CTRL+= para aumentar font size
map("n", "<C-=>", "<cmd>set guifont=*<CR>", { desc = "Increase font size" })

-- CTRL+- para diminuir font size
map("n", "<C-->", "<cmd>set guifont=*<CR>", { desc = "Decrease font size" })

-- CTRL+0 para reset font size
map("n", "<C-0>", "<cmd>set guifont=*<CR>", { desc = "Reset font size" })

-- ============================================================================
-- QUICK ACTIONS (estilo VSCode)
-- ============================================================================
-- CTRL+` para quick terminal toggle
map("n", "<C-`>", "<cmd>ToggleTerm<CR>", { desc = "Quick terminal toggle" })

-- CTRL+SHIFT+` para new terminal
map("n", "<C-S-`>", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = "New terminal" })

-- CTRL+, para abrir settings
map("n", "<C-,>", "<cmd>e $MYVIMRC<CR>", { desc = "Open settings" })

-- ============================================================================
-- LANGUAGE SPECIFIC (Rust e Python)
-- ============================================================================
-- Rust específico
map("n", "<leader>rr", "<cmd>RustRunnables<CR>", { desc = "Rust Runnables" })
map("n", "<leader>rt", "<cmd>RustTest<CR>", { desc = "Rust Test" })
map("n", "<leader>rm", "<cmd>RustExpandMacro<CR>", { desc = "Rust Expand Macro" })
map("n", "<leader>rc", "<cmd>RustOpenCargo<CR>", { desc = "Rust Open Cargo.toml" })

-- Python específico
map("n", "<leader>pt", "<cmd>lua require('dap-python').test_method()<CR>", { desc = "Python Test Method" })
map("n", "<leader>pc", "<cmd>lua require('dap-python').test_class()<CR>", { desc = "Python Test Class" })

-- ============================================================================
-- DESFAZER ALGUNS CONFLITOS COM VIM NATIVO
-- ============================================================================
-- Manter alguns comandos importantes do Vim
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save (Vim style)" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit (Vim style)" })
map("n", "<leader>x", "<cmd>x<CR>", { desc = "Save and quit (Vim style)" })

-- Manter navegação nativa do Vim como alternativa
map("n", "<C-u>", "<C-u>", { desc = "Scroll up (Vim native)" })
map("n", "<C-d>", "<C-d>", { desc = "Scroll down (Vim native)" })
