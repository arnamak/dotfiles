local packer = require("packer")
local use = packer.use

return packer.startup(function()
  use "wbthomason/packer.nvim"
  use "nvim-lua/popup.nvim"
  use "neovim/nvim-lspconfig"
  use "navarasu/onedark.nvim"
  use "kyazdani42/nvim-tree.lua"
  use "hrsh7th/nvim-compe"
  use "ctrlpvim/ctrlp.vim"
  use "matbme/JABS.nvim"
  use "nvim-treesitter/playground"
  use { "nvim-treesitter/nvim-treesitter", config = function() require("treesitter-nvim").config() end }
  use "windwp/nvim-autopairs"
  use "windwp/nvim-ts-autotag"
  use {
    "phaazon/hop.nvim",
    as = "hop",
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require"hop".setup { keys = "etovxqpdygfblzhckisuran" }
    end
  }
  use {
    "lukas-reineke/indent-blankline.nvim",
    branch = "lua",
    event = "BufRead",
    setup = function() require("editor-settings").blankline() end,
    display = { border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" } }
  }
  use "nvim-lua/plenary.nvim"
  use "JoosepAlviste/nvim-ts-context-commentstring"
  use {
    "glepnir/galaxyline.nvim",
    branch = "main",
    -- your statusline
    config = function() require "statusline" end,
    requires = { "arnamak/nvim-nonicons" }
  }
  use "kyazdani42/nvim-web-devicons"
  use { "arnamak/nvim-nonicons", requires = { "kyazdani42/nvim-web-devicons" } }
  use "p00f/nvim-ts-rainbow"
  use {
    "lewis6991/gitsigns.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function() require("gitsigns").setup() end
  }
  use "onsails/lspkind-nvim"
  use "glepnir/lspsaga.nvim"
  use { "pwntester/octo.nvim", config = function() require"octo".setup() end }
  use { "nvim-telescope/telescope.nvim", requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } } }
  use { "ray-x/lsp_signature.nvim" }
  use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
end)
