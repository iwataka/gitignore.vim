if &compatible || (exists('g:loaded_gitignore') && g:loaded_gitignore)
  finish
endif
let g:loaded_gitignore = 1

com! -nargs=* -bang -complete=customlist,gitignore#complete Gitignore
      \ call gitignore#gitignore(<bang>0, <f-args>)
com! GitignoreUpdate call gitignore#update()
