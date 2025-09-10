return {
  -- Tema Tokyo Night (visual, não afeta comandos)
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "moon",
      transparent = false,
    },
  },

  -- Configurar LazyVim para usar o tema
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },

  -- Terminal integrado (sem conflitar com comandos Vim)
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup({
        size = 15,
        direction = "horizontal",
        start_in_insert = true,
        -- SEM remapeamento automático de Ctrl+`
        open_mapping = false,
      })
    end,
  },

  -- File explorer melhorado (mas usando <leader>e)
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

  -- LSP essencial (melhora comandos nativos como gd, gr)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Linguagens já configuradas
        lua_ls = {},
        pyright = {},
        rust_analyzer = {},
        clangd = {
          cmd = { "clangd", "--background-index" },
          filetypes = { "c", "cpp", "objc", "objcpp" },
        },
        omnisharp = {
          cmd = { "omnisharp" },
        },
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
        cs = { "csharpier" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },

  -- Git integration (adiciona sem substituir)
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 1000,
      },
    },
  },

  -- Autocomplete melhorado (sem remapear Tab agressivamente)
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        -- Tab apenas se menu estiver visível
        ["<Tab>"] = { "accept", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
        ["<C-Space>"] = { "show" },
        ["<C-e>"] = { "hide" },
      },
    },
  },

  -- Telescope (essencial para busca, usando <leader>)
  {
    "nvim-telescope/telescope.nvim",
    -- Sem remapeamentos automáticos de Ctrl+P
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
        "c_sharp",
        "asm",
      },
    },
  },
}
