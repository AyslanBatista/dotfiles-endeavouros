return {
  -- Tema Tokyo Night
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "moon",
      transparent = true,
    },
  },

  -- Configurar LazyVim para usar o tema
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },

  -- Terminal integrado
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup({
        size = 15,
        direction = "horizontal",
        start_in_insert = true,
        open_mapping = false,
      })
    end,
  },

  -- File explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      close_if_last_window = true,
      window = {
        position = "left",
        width = 30,
      },
      filesystem = {
        follow_current_file = {
          enabled = true,
        },
        filtered_items = {
          hide_dotfiles = false,
        },
      },
    },
  },

  -- Mason: gerenciamento automático de LSPs
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",
        "pyright",
        "rust_analyzer",
        "clangd",
        "asm_lsp",
      },
    },
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {},
        pyright = {},
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              inlayHints = { enable = false },
              lens = { enable = false },
              completion = {
                callable = { snippets = "none" },
                addCallParenthesis = false,
              },
              checkOnSave = { command = "clippy" },
              assist = {
                importGranularity = "module",
                importPrefix = "by_self",
              },
            },
          },
        },
        clangd = {
          cmd = { "clangd", "--background-index" },
          filetypes = { "c", "cpp", "objc", "objcpp" },
        },
        -- asm_lsp requer um arquivo .asm-lsp.toml no root do projeto
        -- Exemplo mínimo:
        --   [[assembler]]
        --   name = "nasm"
        -- Documentação: https://github.com/bergercookie/asm-lsp
        asm_lsp = {},
      },
    },
  },

  -- Formatação automática
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black", "isort" },
        rust = { "rustfmt" },
        c = { "clang-format" },
        cpp = { "clang-format" },
      },
    },
  },

  -- Git integration
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 1000,
      },
    },
  },

  -- Autocomplete (Tab aceita como VSCode, setas navegam)
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        ["<Tab>"] = { "accept", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
        ["<C-Space>"] = { "show" },
        ["<C-e>"] = { "hide" },
      },
    },
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Find Text" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
    },
  },

  -- Which-key para descobrir comandos
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        ["<leader>f"] = { name = "+find" },
        ["<leader>g"] = { name = "+git" },
        ["<leader>c"] = { name = "+code" },
        ["<leader>t"] = { name = "+terminal" },
        ["<leader>s"] = { name = "+split" },
        ["<leader>r"] = { name = "+rust/hints" },
        ["<leader>o"] = { name = "+outline" },
      },
    },
  },

  -- Treesitter para syntax highlight
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "lua",
        "python",
        "rust",
        "javascript",
        "typescript",
        "html",
        "css",
        "json",
        "yaml",
        "markdown",
        "bash",
        "c",
        "cpp",
        "asm",
        "nasm", -- syntax highlight específico para NASM
      },
    },
  },

  -- Editor hexadecimal nativo para análise de binários
  -- Uso: :HexToggle para alternar entre hex e texto normal
  {
    "RaafatTurki/hex.nvim",
    config = true,
  },

  -- Outline lateral de funções e símbolos
  -- Útil para navegar em arquivos grandes de C/C++/Assembly
  {
    "stevearc/aerial.nvim",
    opts = {
      backends = { "lsp", "treesitter" },
    },
    keys = {
      { "<leader>o", "<cmd>AerialToggle<CR>", desc = "Toggle outline" },
    },
  },
}
