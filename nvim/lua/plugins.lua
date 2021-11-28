local packer = require("packer")
local use = packer.use

return packer.startup(
  function()
    use "matbme/JABS.nvim"
    use "mizlan/iswap.nvim"
    use "folke/trouble.nvim"
    use "hrsh7th/nvim-compe"
    use "tami5/lspsaga.nvim"
    use "b3nj5m1n/kommentary"
    use "windwp/nvim-spectre"
    use "nvim-lua/popup.nvim"
    use "numtostr/FTerm.nvim"
    use "p00f/nvim-ts-rainbow"
    use "onsails/lspkind-nvim"
    use "mboughaba/i3config.vim"
    use "neovim/nvim-lspconfig"
    use "nvim-lua/plenary.nvim"
    use "windwp/nvim-autopairs"
    use "navarasu/onedark.nvim"
    use "windwp/nvim-ts-autotag"
    use "wbthomason/packer.nvim"
    use "ggandor/lightspeed.nvim"
    use "ethanholz/nvim-lastplace"
    use "nvim-treesitter/playground"
    use "arnamak/stay-centered.nvim"
    use "kyazdani42/nvim-web-devicons"
    use { "npxbr/glow.nvim" }
    use "JoosepAlviste/nvim-ts-context-commentstring"
    use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
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
      "glepnir/galaxyline.nvim",
      branch = "main",
      config = function()
        require "statusline"
      end,
      requires = { "arnamak/nvim-nonicons" },
    }
    use { "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } }
    use {
      "pwntester/octo.nvim",
      config = function()
        require"octo".setup()
      end,
    }
    use "gennaro-tedesco/nvim-peekup"
    use "nvim-lua/lsp-status.nvim"
    use "jbyuki/one-small-step-for-vimkind"
  end
)
