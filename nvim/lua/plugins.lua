local packer = require("packer")
local use = packer.use

return packer.startup(
  function()
    use 'wbthomason/packer.nvim'
    use "neovim/nvim-lspconfig"
    use 'navarasu/onedark.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use 'ctrlpvim/ctrlp.vim'
    use {
      'nvim-treesitter/nvim-treesitter',
      config = function()
        require("treesitter-nvim").config()
      end
    }
    use {
      "lukas-reineke/indent-blankline.nvim",
      branch = "lua",
      event = "BufRead",
      setup = function()
        require("editor-settings").blankline()
      end, display = {
        border = {"┌", "─", "┐", "│", "┘", "─", "└", "│"}
      }
    }
  end
)
