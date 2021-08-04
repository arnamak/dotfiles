local lp = require("nvim-lastplace")

lp.setup(
  {
    lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
    lastplace_ignore_filetype = { "gitcommit", "gitrebase", "hgcommit" },
    lastplace_open_folds = true,
  }
)
