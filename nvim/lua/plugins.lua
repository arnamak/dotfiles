local packer = require("packer")
local use = packer.use

return packer.startup(
  function()
    use "npxbr/glow.nvim"
    use {
      "L3MON4D3/LuaSnip",
      config = function()
        require("luasnip").config.set_config { enable_autosnippets = true }
      end,
    }
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-calc"
    use "hrsh7th/nvim-cmp"
    use "matbme/JABS.nvim"
    use "mizlan/iswap.nvim"
    use "folke/trouble.nvim"
    use "hrsh7th/cmp-buffer"
    use "tami5/lspsaga.nvim"
    use "b3nj5m1n/kommentary"
    use "windwp/nvim-spectre"
    use "nvim-lua/popup.nvim"
    use "hrsh7th/cmp-cmdline"
    use "numtostr/FTerm.nvim"
    use "p00f/nvim-ts-rainbow"
    use "onsails/lspkind-nvim"
    use "hrsh7th/cmp-nvim-lsp"
    use "neovim/nvim-lspconfig"
    use "nvim-lua/plenary.nvim"
    use "windwp/nvim-autopairs"
    use "navarasu/onedark.nvim"
    -- use "ray-x/cmp-treesitter"
    use "mboughaba/i3config.vim"
    use "windwp/nvim-ts-autotag"
    use "wbthomason/packer.nvim"
    use "ggandor/lightspeed.nvim"
    use "ethanholz/nvim-lastplace"
    use "saadparwaiz1/cmp_luasnip"
    use "nvim-treesitter/playground"
    use "arnamak/stay-centered.nvim"
    use "jvgrootveld/telescope-zoxide"
    use "kyazdani42/nvim-web-devicons"
    use "lukas-reineke/cmp-under-comparator"
    use "hrsh7th/cmp-nvim-lsp-signature-help"
    use "hrsh7th/cmp-nvim-lsp-document-symbol"
    use "JoosepAlviste/nvim-ts-context-commentstring"
    use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
    use { "David-Kunz/cmp-npm", requires = { "nvim-lua/plenary.nvim" } }
    use { "tzachar/cmp-fuzzy-buffer", requires = { "hrsh7th/nvim-cmp", "tzachar/fuzzy.nvim" } }
    use { "tzachar/cmp-fuzzy-path", requires = { "hrsh7th/nvim-cmp", "hrsh7th/cmp-path", "tzachar/fuzzy.nvim" } }
    use { "arnamak/nvim-nonicons", requires = { "kyazdani42/nvim-web-devicons" } }
    use { "nvim-telescope/telescope.nvim", requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } } }
    use {
      "nvim-treesitter/nvim-treesitter",
      config = function()
        require("treesitter-nvim").config()
      end,
    }
    vim.g.nvim_tree_git_hl = 1
    vim.g.nvim_tree_group_empty = 1
    vim.g.nvim_tree_add_trailing = 1
    vim.g.nvim_tree_quit_on_open = 1
    vim.g.nvim_tree_indent_markers = 1
    vim.g.nvim_tree_icon_padding = " "
    vim.g.nvim_tree_disable_window_picker = 1
    vim.g.nvim_tree_highlight_opened_files = 1
    vim.g.nvim_tree_root_folder_modifier = ":~"
    -- local tree = {}
    -- tree.open = function()
    --   require"bufferline.state".set_offset(31, "FileTree")
    --   require"nvim-tree".find_file(true)
    -- end

    -- tree.close = function()
    --   require"bufferline.state".set_offset(0)
    --   require"nvim-tree".close()
    -- end

    -- require"nvim-tree".setup()
    use {
      "kyazdani42/nvim-tree.lua",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require"nvim-tree".setup {
          nvim_tree_hide_dotfiles = false,
          nvim_tree_gitignore = false,
          disable_netrw = true,
          hijack_netrw = true,
          open_on_setup = false,
          auto_close = false,
          update_to_buf_dir = { enable = true, auto_open = true },
          hijack_cursor = false,
          update_cwd = true,
          diagnostics = { enable = false },
          update_focused_file = { enable = true, update_cwd = true, ignore_list = {} },
          system_open = { cmd = nil, args = {} },
          view = {
            width = "40%",
            height = 30,
            side = "right",
            auto_resize = false,
            mappings = { custom_only = false, list = {} },
          },
        }
      end,
    }
    use {
      "lukas-reineke/indent-blankline.nvim",
      setup = function()
        require("editor-settings").blankline()
      end,
      -- requires = { "nvim-treesitter/nvim-treesitter" },
      after = { "nvim-treesitter" },
    }
    use {
      "NTBBloodbath/galaxyline.nvim",
      config = function()
        require "statusline"
      end,
      requires = { "arnamak/nvim-nonicons" },
    }
    use { "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } }
    use "gennaro-tedesco/nvim-peekup"
    use "nvim-lua/lsp-status.nvim"
    use "jbyuki/one-small-step-for-vimkind"
  end
)
