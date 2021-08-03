require("telescope").setup {
  defaults = {
    border = {},
    winblend = 0,
    use_less = false,
    file_sorter = nil,
    entry_prefix = "  ",
    prompt_prefix = "  ",
    generic_sorter = nil,
    color_devicons = true,
    selection_caret = "-> ",
    initial_mode = "insert",
    scroll_strategy = "cycle",
    path_display = { "shorten" },
    layout_strategy = "vertical",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    file_ignore_patterns = { ".undo/**", ".undo/*" },
    set_env = { ["COLORTERM"] = "truecolor" },
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    file_previewer = require"telescope.previewers".vim_buffer_cat.new,
    grep_previewer = require"telescope.previewers".vim_buffer_vimgrep.new,
    qflist_previewer = require"telescope.previewers".vim_buffer_qflist.new,
    buffer_previewer_maker = require"telescope.previewers".buffer_previewer_maker,
    layout_config = { horizontal = { mirror = true }, vertical = { mirror = false }, bottom_pane = { mirror = false } },
    vimgrep_arguments = {
      "rg",
      "--column",
      "--no-heading",
      "--smart-case",
      "--line-number",
      "--color=never",
      "--with-filename",
    },
  },
  pickers = {
    find_files = {
      border = false,
      sort_lastused = true,
      initial_mode = "insert",
      layout_strategy = "bottom_pane",
      layout_config = { height = 10 },
    },
    oldfiles = {
      border = false,
      sort_lastused = true,
      initial_mode = "insert",
      path_display = { "tail" },
      layout_strategy = "bottom_pane",
      layout_config = { height = 10 },
    },
    lsp_references = {
      border = false,
      theme = "dropdown",
      sort_lastused = true,
      initial_mode = "normal",
      layout_strategy = "bottom_pane",
      layout_config = { height = 10 },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      override_file_sorter = true, -- override the file sorter
      override_generic_sorter = false, -- override the generic sorter
    },
  },
}

require("telescope").load_extension("fzf")
