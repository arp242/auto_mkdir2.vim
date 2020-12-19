" Create the directory path. This will also create any intermediate
" directories.
"
" If confirm is non-0 it will ask for confirmation first.
fun! auto_mkdir2#mkdir_p(path, confirm) abort
	let l:dir = expand(a:path)
	if l:dir is# ''
		let l:dir = expand('%:p:h')
	endif

	if isdirectory(l:dir)
		return
	endif

	if filereadable(l:dir)
		echohl Error | echom printf("%s exists and isn't a directory", l:dir) | echohl None
		return
	endif

	let l:response = 'y'
	if a:confirm
		echohl Question | echon printf('Create directory "%s" [y/N]? ', a:path) | echohl None

		" TODO: When using :wq or ZZ I need to press <CR> here after y?
		let response = nr2char(getchar())
	endif

    if l:response is? 'y'
		call mkdir(iconv(l:dir, &encoding, &termencoding), 'p')
    endif
endfun

fun! auto_mkdir2#autocmd() abort
	return auto_mkdir2#mkdir_p(expand('<amatch>:p:h'), !v:cmdbang && get(g:, 'auto_mkdir2_confirm', 1))
endfun
