" =====================================
" Filename: autoload/vtex.vim
" Author: hwblx
" License: MIT License
" Last Change: 2025/11/13
" =====================================
let s:save_cpo = &cpo
set cpo&vim

let s:term_bufs = {}
let s:prev_win_id = -1

augroup MyTerminals
  autocmd!
  " Register terminal with its associated window
  autocmd WinLeave * let s:prev_win_id = win_getid()

  autocmd TerminalWinOpen *
        \ if s:prev_win_id > 0 |
        \   let s:term_bufs[s:prev_win_id] = bufnr() |
        \ endif
augroup END


function! vtex#send(command)
  if !empty(term_list())
    " Lookup the terminal associated with the current window
    let term_obj = get(get(s:, 'term_bufs', {}), win_getid(), -1)
    let idx = index(term_list(), term_obj)
    "echo s:prev_win_id s:term_bufs term_list() idx
    
    execute 'call term_list()[idx >= 0 ? idx : 0]->term_sendkeys(a:command . "\<CR>")'
  else
    echo "No terminal buffer open or terminal feature unsupported!"
  endif
endfunction


function! vtex#run()
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
    return
  endif

  " Save buffer to temp file
  execute 'silent! write!' fnameescape(script)

  " Build command
  let command = interpreter . ' ' . fnameescape(script)
  
  " Send command to the terminal
  call vtex#send(command)
endfunction


function! vtex#clear()
  " clear terminal
  let command = "clear"
  call vtex#send(command)
endfunction

let &cpo = s:save_cpo

