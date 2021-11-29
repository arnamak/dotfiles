--                    ▋               ▋                               
--                       
--
local gl = require("galaxyline")
local gls = gl.section
local gvcs = require("galaxyline.providers.vcs")
local icons = require("nvim-nonicons")
local condition = require("galaxyline.condition")
local status = require("lsp-status")
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

gls.left[0] = {
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
gls.left[1] = {
  FileName = {
    provider = function()
      local current_dir = "  " .. vim.fn.expand("%:p:h") .. "  "
      if (require("galaxyline.condition").check_git_workspace()) then
        local git_dir = require("galaxyline.providers.vcs").get_git_dir(vim.fn.expand("%:p"))
        if git_dir == current_dir .. "/.git" or git_dir == nil then
          return current_dir
        end
        local get_path_from_git_root = current_dir:sub(#git_dir - 4)
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

gls.right[1] = {
  DiffAdd = {
    provider = function()
      return "  "
    end,
    condition = condition.buffer_not_empty,
    highlight = function()
      if gvcs.diff_add() == nil then
        return { colors.faded_black }
      else
        return { colors.faded_cyan }
      end
    end,
  },
}

gls.right[2] = {
  DiffModified = {
    provider = function()
      return "  "
    end,
    condition = condition.buffer_not_empty,
    highlight = function()
      if gvcs.diff_modified() == nil then
        return { colors.faded_black }
      else
        return { colors.faded_blue }
      end
    end,
  },
}

gls.right[3] = {
  DiffRemove = {
    provider = function()
      return " "
    end,
    condition = condition.buffer_not_empty,
    highlight = function()
      if gvcs.diff_remove() == nil then
        return { colors.faded_black }
      else
        return { colors.faded_red }
      end
    end,
  },
}
gls.right[4] = {
  DiagnosticWarn = {
    provider = function()
      return "⸽🄾 "
    end,
    highlight = function()
      if status.diagnostics().warnings == 0 then
        return { colors.faded_black }
      else
        return { colors.yellow }
      end
    end,
    separator = " ",
    separator_highlight = { colors.bg },
  },
}
gls.right[5] = {
  DiagnosticError = {
    provider = function()
      return "🅇 ⸽"
    end,
    highlight = function()
      if status.diagnostics().errors == 0 then
        return { colors.faded_black }
      else
        return { colors.faded_red }
      end
    end,
    separator = "",
    separator_highlight = { colors.bg },
  },
}
gls.right[6] = {
  GitBranch = {
    provider = "GitBranch",
    icon = "" .. icons.get("git-branch") .. " ",
    separator = "",
    separator_highlight = { colors.bg },
    highlight = { colors.faded_black },
    condition = require("galaxyline.condition").check_git_workspace,
  },
}
gls.right[7] = {
  EndGap = {
    provider = function()
      return ""
    end,
    condition = condition.hide_in_width,
    separator = " ",
  },
}
