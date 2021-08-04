
"""""""""""""""""""""""""""""""""""
" Show coverage report if it exists
"""""""""""""""""""""""""""""""""""

function! SetupCoverage()
  if filereadable("coverage.vim")
    source coverage.vim
  endif
endfunction


set makeprg=rake
call SetupCoverage()


" autocmd BufWritePre * :!standardrb --fix % &
