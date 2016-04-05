let s:save_cpo = &cpoptions
set cpoptions&vim

if !exists('g:gitignore_dir')
  let g:gitignore_dir = '~/.gitignore-boilerplates'
endif
let s:gitignore_url = 'https://github.com/github/gitignore'

fu! gitignore#gitignore(bang, ...)
  if !a:0
    return
  endif

  let template_dir = s:validate_path(g:gitignore_dir)
  " Clone the gitignore collection if not exists
  if !isdirectory(template_dir)
    call gitignore#update()
  endif

  " Detect the project root
  let root = s:project_root(expand('%:p'))
  if empty(root)
    let path = input('Where is your .gitignore? ', '', 'file')
    if isdirectory(path)
      let gitignore = path.'/.gitignore'
    else
      let gitignore = path
    endif
  else
    let gitignore = root.'/.gitignore'
  endif

  let blocks = map(copy(a:000), 's:patterns(v:val)')
  if !a:bang && filereadable(gitignore)
    let content = readfile(gitignore)
    call filter(blocks, '!s:check_inclusion(content, v:val)')
    let blocks = [readfile(gitignore)] + blocks
  endif
  let lines = s:join_blocks(blocks)
  call writefile(lines, gitignore)
endfu

fu! gitignore#update()
  let template_dir = s:validate_path(g:gitignore_dir)
  if isdirectory(template_dir)
    let cwd = getcwd()
    " There are some ways to execute Git commands outside the repository, but
    " they depend on the version and version detection is not easy.
    " See http://stackoverflow.com/questions/5083224/git-pull-while-not-in-a-git-directory and others
    " git --git-dir=~/foo/.git --work-tree=~/foo status
    " git -C ~/foo status (since Git 2.3.4, March 2015)
    call s:cd_or_lcd(template_dir)
    call system('git pull origin master')
    call s:cd_or_lcd(cwd)
  else
    let cmd = 'git clone '.s:gitignore_url
    call system(cmd.' '.template_dir)
  endif
endfu

fu! gitignore#complete(A, L, P)
  return filter(s:types(), 'v:val =~ "^".a:A')
endfu

fu! s:patterns(type)
  let template_dir = s:validate_path(g:gitignore_dir)
  let result = []
  for file in split(glob(template_dir.'/**/'.a:type.'.gitignore'), '\n')
    let result += readfile(file)
  endfor
  return result
endfu

fu! s:types()
  let template_dir = s:validate_path(g:gitignore_dir)
  let list = split(globpath(template_dir, '**/*.gitignore'), '\n')
  call map(list, 'fnamemodify(v:val, ":t")')
  call map(list, 'substitute(v:val, "\\v\\.gitignore$", "", "")')
  let s:types = list
  return s:types
endfu

fu! s:project_root(cwd)
  let gitdir = s:validate_path(finddir('.git', a:cwd.';'))
  if !empty(gitdir)
    return fnamemodify(gitdir, ':h')
  endif
  return ''
endfu

fu! s:cd_or_lcd(dir)
  if haslocaldir()
    exe 'lcd '.a:dir
  else
    exe 'cd '.a:dir
  endif
endfu

fu! s:join_blocks(blocks)
  let result = []
  for block in a:blocks
    if empty(block)
      continue
    endif
    if !empty(result) && !empty(result[-1])
      call add(result, '')
    endif
    let result += block
  endfor
  return result
endfu

fu! s:validate_path(path)
  return substitute(fnamemodify(a:path, ':p'), '\v/+$', '', '')
endfu

fu! s:check_inclusion(whole, part)
  if empty(a:part)
    return 0
  endif
  let start = index(a:whole, a:part[0])
  if len(a:whole) < start + len(a:part)
    return 0
  endif
  for i in range(0, len(a:part) - 1)
    if a:whole[start + i] != a:part[i]
      return 0
    endif
  endfor
  return 1
endfu

let &cpo = s:save_cpo
unlet s:save_cpo
