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

nnoremap <buffer><silent> get :call g:InsertRestSnippets('GET')<cr>
nnoremap <buffer><silent> post :call g:InsertRestSnippets('POST')<cr>
nnoremap <buffer><silent> put :call g:InsertRestSnippets('PUT')<cr>
nnoremap <buffer><silent> del :call g:InsertRestSnippets('DELETE')<cr>
nnoremap <buffer><silent> file :call g:InsertRestSnippets('FilePath')<cr>
nnoremap <buffer><silent> n :<C-U>call g:FastJumpToRestBlock('next', v:count1)<cr>
nnoremap <buffer><silent> N :<C-U>call g:FastJumpToRestBlock('previous', v:count1)<cr>
