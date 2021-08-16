--
--
--
--                    ▋               ▋                               
--                       
--
local gl = require("galaxyline")
local gls = gl.section
local gvcs = require("galaxyline.provider_vcs")
local icons = require("nvim-nonicons")
local condition = require("galaxyline.condition")
local lsp_stat = require("lsp-status")
gl.short_line_list = { "packer", "NvimTree", "term" }
local colors = {
  white = "#eff0eb",
  cyan = "#2e313d",
  magenta = "#ff6ac1",
  blue = "#57c7ff",
  yellow = "#f3f99d",
  green = "#5af78e",
  red = "#ff5c57",
  black = "#686868",
  bg = "#282a36",
  fg = "#eff0eb",
  faded_black = "#2e313d",
  black_alt = "#191c25",
  faded_cyan = "#659ea2",
  faded_blue = "#a0b9d8",
  faded_red = "#cf8164",
}

gls.left[1] = {
  StartGap = {
    provider = function()
      return ""
    end,
    separator = "",
    separator_highlight = { colors.faded_black },
  },
}
gls.left[2] = {
  ViMode = {
    provider = function()
      local mode = {
        n = { color = "String", icon = "🄽" },
        i = { color = "Function", icon = "🄸" },
        v = { color = "Conditional", icon = "🅅" },
        V = { color = "Conditional", icon = "🅅" },
        [""] = { color = "Conditional", "🅅" },
        c = { color = "Keyword", icon = "🄲" },
        ["!"] = { color = "Keyword", icon = "🄲" },
        R = { color = "Keyword", icon = "🅁" },
        r = { color = "Keyword", icon = "🅁" },
      }
      vim.api.nvim_command("hi link GalaxyViMode " .. mode[vim.fn.mode()].color)
      if mode[vim.fn.mode()].icon ~= nil then
        return " " .. mode[vim.fn.mode()].icon
      end
    end,
    separator = " ",
    separator_highlight = { colors.faded_black },
  },
}
gls.left[3] = {
  StartGap = {
    provider = function()
      return ""
    end,
    separator = " ",
    separator_highlight = { colors.faded_cyan },
  },
}
gls.left[4] = {
  FileName = {
    provider = function()
      local current_dir = "  " .. vim.fn.expand("%:p:h") .. "  "
      if (require("galaxyline.condition").check_git_workspace()) then
        local git_dir = require("galaxyline.provider_vcs").get_git_dir(vim.fn.expand("%:p"))
        if git_dir == current_dir .. "/.git" or git_dir == nil then
          return current_dir
        end
        local get_path_from_git_root = current_dir:sub(#git_dir - 3)
        return "  /" .. get_path_from_git_root
      end
      return current_dir
    end,
    separator = "",
    separator_highlight = { colors.faded_black },
    highlight = { colors.faded_blue, colors.faded_black, "italic" },
    condition = condition.hide_in_width or condition.buffer_not_empty,
  },
}
gls.left[5] = {
  StartGap = {
    provider = function()
      return " "
    end,
    condition = condition.buffer_not_empty,
    separator = "ꞏꞏꞏꞏꞏꞏꞏꞏꞏꞏꞏꞏꞏꞏꞏꞏꞏꞏꞏꞏꞏꞏꞏꞏꞏꞏꞏꞏꞏꞏꞏꞏ",
    separator_highlight = { colors.faded_cyan },
  },
}
gls.left[6] = {
  DiffAdd = {
    provider = function()
      local icon = "  "
      local diff_add = gvcs.diff_add() or "0 "
      return icon .. diff_add
    end,
    condition = condition.buffer_not_empty,
    highlight = { colors.faded_cyan },
  },
}

gls.left[7] = {
  DiffModified = {
    provider = function()
      local diff_modified = gvcs.diff_modified() or "0 "
      local icon = "  "
      return icon .. diff_modified
    end,
    condition = condition.buffer_not_empty,
    highlight = { colors.faded_blue },
  },
}

gls.left[8] = {
  DiffRemove = {
    provider = function()
      local diff_remove = gvcs.diff_remove() or "0 "
      local icon = "  "
      return icon .. diff_remove
    end,
    condition = condition.buffer_not_empty,
    highlight = { colors.faded_red },
  },
}
gls.left[9] = {
  StartGap = {
    provider = function()
      return " "
    end,
    condition = condition.buffer_not_empty,
    separator = "ꞏꞏꞏꞏꞏꞏꞏꞏꞏꞏꞏꞏꞏꞏꞏꞏꞏꞏꞏꞏꞏꞏꞏꞏꞏꞏꞏꞏꞏꞏꞏꞏ",
    separator_highlight = { colors.white, colors.white },
  },
}
gls.right[1] = {
  lsp_status = {
    provider = function()
      local clients = vim.lsp.get_active_clients()
      if next(clients) ~= nil then
        return lsp_stat.status() .. "  " .. " LSP "
      else
        return ""
      end
    end,
    separator = "▋",
    separator_highlight = { colors.bg },
  },
}
gls.right[2] = {
  FileIcon = { separator = " ", provider = "FileIcon",
               condition = condition.hide_in_width or condition.buffer_not_empty },
}
gls.right[3] = {
  FileTypeName = {
    provider = function()
      local ft = vim.bo.filetype
      if (ft) == "typescriptreact" then
        return "tsx"
      else
        return vim.bo.filetype
      end
    end,
    condition = condition.hide_in_width or condition.buffer_not_empty,
  },
}
gls.right[4] = {
  GitBranch = {
    provider = "GitBranch",
    icon = " " .. icons.get("git-branch") .. " ",
    separator = "  ▋",
    separator_highlight = { colors.bg },
    highlight = { colors.faded_black },
    condition = require("galaxyline.condition").check_git_workspace,
  },
}
gls.right[6] = {
  -- 
  EndGap = {
    provider = function()
      return ""
    end,
    condition = condition.hide_in_width,
    separator = " ",
  },
}
