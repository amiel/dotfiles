function! s:OpenEmberComponentLayout(...)
  only

  if a:0
    let name = a:1
    e README.md " Ecomponent requires _some_ buffer in the project being open
    exec "Ecomponent ". name
  else
    let name = substitute(expand("%:r"), '.*app/components/', '', "g")
  endif

  wincmd v
  wincmd l
  exec "Etemplate templates/components/". name
  wincmd h
  wincmd s
  wincmd j
  :A
  wincmd k
endfunction
command! -nargs=? EmberComponentLayout :call s:OpenEmberComponentLayout(<f-args>)

function! s:OpenEmberServiceLayout(...)
  only

  if a:0
    let name = a:1
    e README.md " Ecomponent requires _some_ buffer in the project being open
    exec "Eservice ". name
  else
    let name = substitute(expand("%:r"), '.*app/services/', '', "g")
  endif

  wincmd v
  wincmd l
  :A
  wincmd h
endfunction
command! -nargs=? EmberServiceLayout :call s:OpenEmberServiceLayout(<f-args>)
