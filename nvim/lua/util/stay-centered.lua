vim.api.nvim_exec(
  [[
    :function StayCentered()
    :  let line = line(".")
    :  if line != get(b:, 'last_line', 0)
    :    normal! zz
    :    let b:last_line = line
    :  endif
    :endfunction
    :command StayCentered :call StayCentered()
    augroup StayCentered
      autocmd!
      autocmd CursorMoved,CursorMovedI * :StayCentered
    augroup END
  ]], true
)
