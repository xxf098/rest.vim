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

nnoremap <buffer><silent> get :call g:InsertRestSnippets('GET')<cr>
nnoremap <buffer><silent> post :call g:InsertRestSnippets('POST')<cr>
nnoremap <buffer><silent> put :call g:InsertRestSnippets('PUT')<cr>
nnoremap <buffer><silent> del :call g:InsertRestSnippets('DELETE')<cr>
nnoremap <buffer><silent> file :call g:InsertRestSnippets('FilePath')<cr>
