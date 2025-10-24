" =====================================
" Filename: autoload/vtex.vim
" Author: hwblx
" License: MIT License
" Last Change: 2025/10/24
" =====================================

let s:save_cpo = &cpo
set cpo&vim


func! s:Vtex()
  let ext = expand('%:e')

  if ext ==# 'py'
    let $script = '/tmp/.vimterm.py'
    let interpreter = 'python3'

  elseif ext ==# 'js'
    let $script = '/tmp/.vimterm.js'
    let interpreter = 'node'

  elseif ext ==# 'sh'
    let $script = '/tmp/.vimterm.sh'
    let interpreter = 'bash'

  elseif ext ==# 'rb'
    let $script = '/tmp/.vimterm.rb'
    let interpreter = 'ruby'

  elseif ext ==# 'pl'
    let $script = '/tmp/.vimterm.pl'
    let interpreter = 'perl'

  elseif ext ==# 'php'
    let $script = '/tmp/.vimterm.php'
    let interpreter = 'php'

  elseif ext ==# 'lua'
    let $script = '/tmp/.vimterm.lua'
    let interpreter = 'lua'

  else
    echo "Unsupported file type: " . ext
    finish
  endif

  " Save buffer to temp file
  :silent! w! $script

  " Build command string
  let command = interpreter . ' ' . $script

  " Send to the first terminal buffer
  call term_list()[0]->term_sendkeys(command . "\<CR>")


let &cpo = s:save_cpo
unlet s:save_cpo
