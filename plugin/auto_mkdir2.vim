" auto_mkdir2.vim: Automatically create directories
"
" https://github.com/arp242/auto_mkdir2.vim
"
" See the bottom of this file for copyright & license information.


scriptencoding utf-8
if exists('g:loaded_auto_mkdir2') | finish | endif
let g:loaded_auto_mkdir2 = 1
let s:save_cpo = &cpo
set cpo&vim


command! -nargs=* -complete=dir MkdirP call s:mkdir_p(<q-args>, 1)

augroup auto_mkdir2
	autocmd!
	autocmd BufWritePre * call s:mkdir_p(expand("<amatch>:p:h"), v:cmdbang)
augroup end


fun! s:mkdir_p(path, never_ask) abort
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
	if !a:never_ask && get(g:, 'auto_mkdir2_confirm', 1)
		echohl Question | echon printf('Create directory "%s" [y/N]? ', a:path) | echohl None

		" TODO: When using :wq or ZZ I need to press <CR> here after y?
		let response = nr2char(getchar())
	endif

    if l:response is? 'y'
		call mkdir(iconv(l:dir, &encoding, &termencoding), 'p')
    endif
endfun


let &cpo = s:save_cpo
unlet s:save_cpo


" The MIT License (MIT)
"
" Copyright © 2015-2017 Martin Tournoij
"
" Permission is hereby granted, free of charge, to any person obtaining a copy
" of this software and associated documentation files (the "Software"), to
" deal in the Software without restriction, including without limitation the
" rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
" sell copies of the Software, and to permit persons to whom the Software is
" furnished to do so, subject to the following conditions:
"
" The above copyright notice and this permission notice shall be included in
" all copies or substantial portions of the Software.
"
" The software is provided "as is", without warranty of any kind, express or
" implied, including but not limited to the warranties of merchantability,
" fitness for a particular purpose and noninfringement. In no event shall the
" authors or copyright holders be liable for any claim, damages or other
" liability, whether in an action of contract, tort or otherwise, arising
" from, out of or in connection with the software or the use or other dealings
" in the software.
