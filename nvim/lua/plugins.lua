local packer = require("packer")
local use = packer.use

return packer.startup(
  function()
    use "matbme/JABS.nvim"
    use "hrsh7th/nvim-compe"
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
    use "ray-x/lsp_signature.nvim"
    use "kyazdani42/nvim-tree.lua"
    use "nvim-treesitter/playground"
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
      "phaazon/hop.nvim",
      as = "hop",
      config = function()
        require"hop".setup { keys = "etovxqpdygfblzhckisuran" }
      end,
    }
    use {
      "lukas-reineke/indent-blankline.nvim",
      branch = "lua",
      event = "BufRead",
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
    use {
      "lewis6991/gitsigns.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      config = function()
        require("gitsigns").setup()
      end,
    }
    use {
      "pwntester/octo.nvim",
      config = function()
        require"octo".setup()
      end,
    }
  end
)
