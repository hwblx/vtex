" =====================================
" Filename: autoload/vtex.vim
" Author: hwblx
" License: MIT License
" Last Change: 2025/10/24
" =====================================

function! vtex#run()
  let s:save_cpo = &cpo
  set cpo&vim

  " Determine interpreter based on file extension
  let ext = expand('%:e')

  if ext ==# 'py'
    let script = '/tmp/.vimterm.py'
    let interpreter = 'python3'
  elseif ext ==# 'js'
    let script = '/tmp/.vimterm.js'
    let interpreter = 'node'
  elseif ext ==# 'sh'
    let script = '/tmp/.vimterm.sh'
    let interpreter = 'bash'
  elseif ext ==# 'rb'
    let script = '/tmp/.vimterm.rb'
    let interpreter = 'ruby'
  elseif ext ==# 'pl'
    let script = '/tmp/.vimterm.pl'
    let interpreter = 'perl'
  elseif ext ==# 'php'
    let script = '/tmp/.vimterm.php'
    let interpreter = 'php'
  elseif ext ==# 'lua'
    let script = '/tmp/.vimterm.lua'
    let interpreter = 'lua'
  else
    echo "Unsupported file type: " . ext
    let &cpo = s:save_cpo
    return
  endif

  " Save buffer to temp file
  execute 'silent! write!' fnameescape(script)

  " Build command string
  let command = interpreter . ' ' . fnameescape(script)

  " Send to the first terminal buffer (string-evaluated for Vim 8.0 safety)
  if exists('*term_list')
    execute 'call term_list()[0]->term_sendkeys(command . "\<CR>")'
  else
    echo "No terminal buffer open or terminal feature unsupported!"
  endif

  let &cpo = s:save_cpo
endfunction

