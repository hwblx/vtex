" =====================================
" Filename: plugin/vtex.vim
" Author: hwblx
" License: MIT License
" Last Change: 2025/11/02
" =====================================
let s:save_cpo = &cpo
set cpo&vim

if exists('g:loaded_vtex')
  finish
endif

if has('nvim')
  let version_info = execute('version')
  let version_line = split(version_info, "\n")[0]
  let version_number = split(version_line[-5:], '\.')
  if version_number[0] < 1 && (version_number[1] < 4
        \ || (version_number[1] == 4 && version_number[2] < 4))
    echo 'vtex requires nvim version >= 0.4.4'
    finish
  endif
elseif v:version < 801
  echo 'vtex requires vim version >= 8.01'
  finish
endif

let g:loaded_vtex = 1

let s:vtex_paths = [
      \ '~/.local/share/nvim/plugged/vtex/autoload/vtex.vim',
      \ '~/.local/share/nvim/site/pack/plugins/start/vtex/autoload/vtex.vim',
      \ '~/.local/share/nvim/site/pack/plugins/opt/vtex/autoload/vtex.vim',
      \ '~/.config/nvim/autoload/vtex.vim',
      \ '~/.vim/plugged/vtex/autoload/vtex.vim',
      \ '~/.vim/pack/plugins/start/vtex/autoload/vtex.vim',
      \ '~/.vim/pack/plugins/opt/vtex/autoload/vtex.vim',
      \ '~/.vim/autoload/vtex.vim',
      \ ]

let s:sourced = 0
for s:path in s:vtex_paths
  let s:fullpath = expand(s:path)
  if filereadable(s:fullpath)
    execute 'source' fnameescape(s:fullpath)
    let s:sourced = 1
    break
  endif
endfor

if !s:sourced
  echohl WarningMsg | echom 'autoload/vtex.vim not found' | echohl None
  finish
endif

if exists('*vtex#run')
  nnoremap <silent> <S-F8> :call vtex#run()<CR>
  inoremap <silent> <S-F8> <C-o>:call vtex#run()<CR>
endif

if exists('*vtex#clear')
  nnoremap <silent> <S-F9> :call vtex#clear()<CR>
  inoremap <silent> <S-F9> <C-o>:call vtex#clear()<CR>
endif

let &cpo = s:save_cpo
unlet s:save_cpo

