function! g:InsertRestSnippets(type)
  let type = a:type
  execute "normal! G\<esc>^"
  let startLine = search('^###', 'cn')
  if startLine == 0
    return
  endif
  call cursor(startLine, 0)
  execute "normal! o###\<esc>^"
  execute "normal! O{{ HOST }}\<esc>^"
  if type =~? '^\(GET\|PUT\|POST\|DELETE\)$'
    execute "normal! O" . toupper(type) . "\<esc>^"
  endif
  if type =~? "FilePath"
    execute "normal! OPOST\<esc>^"
    execute "normal! joFilePath excelFile=@\<esc>^"
  endif
  execute ":" . startLine
  execute "normal! jj$"
endfunction

function! g:FastJumpToRestBlock(direction, count)
  let idx = 0
  while idx < a:count
    let flags = 'c'
    if a:direction == 'previous'
      let flags = 'b'
      let previousLine = getline(line('.') - 1)
      if previousLine =~ '^\(GET\|PUT\|POST\|DELETE\)$'
        execute "normal! k"
      endif
    endif
    let lineNum = search('^\(GET\|PUT\|POST\|DELETE\)$', flags)
    if lineNum
      execute "normal! j"
    endif
    let idx += 1
  endwhile
endfunction

"support dir yir
function! s:SelectRestBlock(inner, visual)
  let up_num = search('^###', 'bcn')
  let down_num = search('^###', 'cn')
  if up_num == 0 || down_num == 0 || down_num < up_num
    return
  endif
  if up_num == down_num
    let down_num = search('^###', 'n')
  endif
  " execute  up_num . ',' . (down_num - 1) . 'd'
  execute 'normal! ' . up_num . 'ggV'
  execute 'normal! ' . (down_num - up_num -1) . 'j'
endfunction

nnoremap <buffer><silent> get :call g:InsertRestSnippets('GET')<cr>
nnoremap <buffer><silent> post :call g:InsertRestSnippets('POST')<cr>
nnoremap <buffer><silent> put :call g:InsertRestSnippets('PUT')<cr>
nnoremap <buffer><silent> del :call g:InsertRestSnippets('DELETE')<cr>
nnoremap <buffer><silent> file :call g:InsertRestSnippets('FilePath')<cr>
nnoremap <buffer><silent> <c-j> :<C-U>call g:FastJumpToRestBlock('next', v:count1)<cr>
nnoremap <buffer><silent> <c-k> :<C-U>call g:FastJumpToRestBlock('previous', v:count1)<cr>
" nnoremap <buffer><silent> <c-d> :call g:SelectRestBlock()<cr>
vnoremap <silent> ir <ESC>:call <SID>SelectRestBlock(1, 1)<CR>
vnoremap <silent> ar <ESC>:call <SID>SelectRestBlock(0, 1)<CR>
onoremap <silent> ir :call <SID>SelectRestBlock(1, 0)<CR>
onoremap <silent> ar :call <SID>SelectRestBlock(0, 0)<CR>
