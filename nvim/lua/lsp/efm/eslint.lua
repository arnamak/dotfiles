return {
  lintCommand = "eslint_d -f visualstudio --stdin --stdin-filename ${INPUT}",
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = {
    -- :h errorformat
    "%f(%l,%c): %tarning %m",
    "%f(%l,%c): %rror %m",
  },
  lintSource = "eslint",
}
