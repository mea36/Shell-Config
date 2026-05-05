-- Set leader before lazy loads plugins so keymaps use the correct leader
vim.g.mapleader = ","

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin specifications
require("lazy").setup({
  -- match-up: highlight, navigate, and operate on sets of matching text
  {
    "andymass/vim-matchup",
    event = "BufReadPost",
  },

  -- Fast color name highlighter
  {
    "ap/vim-css-color",
    event = { "BufReadPre", "BufNewFile" },
  },

  -- ALE: Asynchronous linting and LSP support
  {
    "dense-analysis/ale",
    lazy = false,
  },

  -- Direnv integration
  {
    "direnv/direnv.vim",
    lazy = false,
  },

  -- FZF session management
  {
    "dominickng/fzf-session.vim",
    dependencies = { "junegunn/fzf.vim" },
    cmd = { "Sessions" },
  },

  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreview", "MarkdownPreviewStop" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },

  -- Better search highlighting
  {
    "wincent/loupe",
    event = "VeryLazy",
  },

  -- Treesitter: Advanced syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    cond = vim.fn.has("nvim") == 1,
    config = function()
      require("nvim-treesitter").setup({
        ensure_installed = {
          "javascript", "typescript", "tsx",
          "css", "html",
          "python", "elixir",
          "markdown", "markdown_inline",
          "json", "yaml",
          "bash", "lua",
          "vim", "vimdoc",
        },
      })
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
    end,
  },

  -- Gundo: Visualize undo tree
  {
    "sjl/gundo.vim",
    cmd = { "GundoToggle", "GundoShow" },
  },

  -- Commentary: Easy commenting
  {
    "tpope/vim-commentary",
    keys = { "gc", "gcc" },
  },

  -- Fugitive: Git integration
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gstatus", "Gblame", "Gpush", "Gpull" },
  },

  -- Rhubarb: GitHub integration for fugitive
  {
    "tpope/vim-rhubarb",
    dependencies = { "tpope/vim-fugitive" },
  },

  -- Supertab: Tab completion
  {
    "ervandew/supertab",
    event = "InsertEnter",
  },

  -- NERDTree: File explorer
  {
    "preservim/nerdtree",
    cmd = { "NERDTree", "NERDTreeFind", "NERDTreeToggle" },
  },

  -- FZF: Fuzzy finder
  {
    "junegunn/fzf",
    build = "./install --all",
  },

  -- FZF vim integration
  {
    "junegunn/fzf.vim",
    dependencies = { "junegunn/fzf" },
    keys = {
      { "<leader>f", "<cmd>Files<cr>", desc = "FZF Files" },
    },
    cmd = { "Files", "GFiles", "Buffers", "Ag", "Rg" },
    config = function()
      vim.env.FZF_DEFAULT_COMMAND = "fd --type f --hidden --exclude .git --exclude node_modules --exclude _build --exclude deps --exclude .elixir_ls"
    end,
  },

  -- LazyGit: Git TUI integration
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- Tender colorscheme
  {
    "jacoborus/tender.vim",
    lazy = false,
    priority = 1000,
  },

  -- Claude Code integration
  {
    "greggh/claude-code.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("claude-code").setup({
        keymaps = {
          toggle = {
            normal = "<leader>cc",
            terminal = "<leader>cc",
          },
        },
      })
    end,
  },
}, {
  -- lazy.nvim configuration options
  install = {
    colorscheme = { "tender" },
  },
  checker = {
    enabled = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- Elixir: use treesitter for folding since the syntax file defines no fold regions
vim.api.nvim_create_autocmd("FileType", {
  pattern = "elixir",
  callback = function()
    vim.opt_local.foldmethod = "expr"
    vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.opt_local.foldlevel = 99
  end,
})

-- Source the existing vimrc for all settings and keybindings
vim.cmd("source ~/.vimrc")
