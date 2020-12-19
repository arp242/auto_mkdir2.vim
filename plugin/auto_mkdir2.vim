" auto_mkdir2.vim: Automatically create directories
"
" https://github.com/arp242/auto_mkdir2.vim


scriptencoding utf-8
if exists('g:loaded_auto_mkdir2') | finish | endif
let g:loaded_auto_mkdir2 = 1
let s:save_cpo = &cpo
set cpo&vim


command! -bang -nargs=* -complete=dir MkdirP call auto_mkdir2#mkdir_p(<q-args>, <bang>get(g:, 'auto_mkdir2_confirm', 1))

let s:x = get(g:, 'auto_mkdir2_autocmd', '*')
if s:x isnot# ''
	augroup auto_mkdir2
		au!
		exe printf("au BufWritePre %s call auto_mkdir2#autocmd()", s:x)
	augroup end
endif


let &cpo = s:save_cpo
unlet s:save_cpo
