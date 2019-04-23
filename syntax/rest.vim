if exists("b:current_syntax")
  finish
endif
syn case ignore

syn match RestGet "^GET$" containedin=ALL
hi RestGet ctermfg=white ctermbg=green guifg=white guibg=green
syn match RestModify "^\(POST\|PUT\|DELETE\)$" containedin=ALL
hi RestModify ctermfg=white ctermbg=red guifg=white guibg=red
syn match RestVar "^{{\s*.*\s*}}" containedin=ALL
hi def link RestVar Keyword

let b:current_syntax = "rest"
