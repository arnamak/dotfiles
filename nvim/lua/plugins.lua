local packer = require("packer")
local use = packer.use

return packer.startup(
  function()
    use "matbme/JABS.nvim"
    use "hrsh7th/nvim-compe"
    use "b3nj5m1n/kommentary"
    use "windwp/nvim-spectre"
    use "nvim-lua/popup.nvim"
    use "p00f/nvim-ts-rainbow"
    use "onsails/lspkind-nvim"
    use "glepnir/lspsaga.nvim"
    use "neovim/nvim-lspconfig"
    use "nvim-lua/plenary.nvim"
    use "windwp/nvim-autopairs"
    use "navarasu/onedark.nvim"
    use "windwp/nvim-ts-autotag"
    use "wbthomason/packer.nvim"
    use "ggandor/lightspeed.nvim"
    use "kyazdani42/nvim-tree.lua"
    use "ethanholz/nvim-lastplace"
    use "nvim-treesitter/playground"
    use "arnamak/stay-centered.nvim"
    use "kyazdani42/nvim-web-devicons"
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
    use {
      "lukas-reineke/indent-blankline.nvim",
      setup = function()
        require("editor-settings").blankline()
      end,
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
  end
)
