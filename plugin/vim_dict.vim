"======================================================================
"
" vim_dict.vim - 
"
" Created by skywind on 2020/03/03
" Last Modified: 2020/03/03 01:53:33
"
"======================================================================


"----------------------------------------------------------------------
" global config
"----------------------------------------------------------------------

" additional dict folder
let g:vim_dict_dict = get(g:, 'vim_dict_dict', [])

" additional tags folder
let g:vim_dict_tags = get(g:, 'vim_dict_tags', [])

" file type remap, eg: 'html': ['css', 'javascript']
let g:vim_dict_config = get(g:, 'vim_dict_config', {})

" weather or not add to tags for given filetype
let g:vim_dict_enable_tags = get(g:, 'vim_dict_enable_tags', {})


"----------------------------------------------------------------------
" internal config
"----------------------------------------------------------------------

" default location
let s:dict = expand(fnamemodify(expand('<sfile>'), ':p:h:h') . '/dict')

let s:tags = expand(fnamemodify(expand('<sfile>'), ':p:h:h') . '/tags')

" default remap
let s:config = {
			\ "html" : ['css', 'javascript', 'css3'],
			\ }

let s:windows = has('win32') || has('win64') || has('win95') || has('win16')


"----------------------------------------------------------------------
" collect file list
"----------------------------------------------------------------------

" search dict files from location
function! s:collect_location(ft, locations)
	let source = []
	for name in a:locations
		let name = fnamemodify(name, ':p')
		if name =~ '^.\+[\/\\]$'
			let name = strpart(name, 0, strlen(name) - 1)
		endif
		let source += [expand(name)]
	endfor
	let paths = join(source, ',')
	let names = globpath(paths, '**/' . a:ft . '.*')
	return split(names, "\n")
endfunc

function! s:pathcase(path)
	if has('win32') || has('win95') || has('win16') || has('win64')
		return tr(tolower(a:path), '/', "\\")
	else
		return a:path
	endif
endfunc

function! s:contains(rtp, filename)
	let name = s:pathcase(a:filename)
	for path in split(a:rtp, ',')
		if s:pathcase(path) == name
			return 1
		endif
	endfor
	return 0
endfunc

function! s:load_dict(ft)
	let names = []
	let fts = [a:ft]
	if has_key(g:vim_dict_config, a:ft)
		let hh = g:vim_dict_config[a:ft]
		if type(hh) == type([])
			let fts = hh
		elseif type(hh) == type('')
			let fts = []
			for ft in split(hh, ',')
				let ft = substitute(ft, '^\s*\(.\{-}\)\s*$', '\1', '')
				if ft != ''
					let fts += [ft]
				endif
			endfor
		else
			let fts = []
		endif
	endif
	let dict = [s:dict] + g:vim_dict_dict
	let tags = [s:tags] + g:vim_dict_tags
	for ft in fts
		let names = s:collect_location(ft, dict)
		for name in names
			if filereadable(name)
				if s:contains(&dictionary, name) == 0
					exec 'setlocal dictionary+=' . fnameescape(name)
				endif
			endif
		endfor
	endfor
	if get(g:vim_dict_enable_tags, a:ft, 0) != 0
		let names = s:collect_location(a:ft, tags)
		for name in names
			if filereadable(name)
				if s:contains(&tags, name) == 0
					exec 'setlocal tags+=' . fnameescape(name)
				endif
			endif
		endfor
	endif
endfunc



"----------------------------------------------------------------------
" autocmd
"----------------------------------------------------------------------
augroup VimDictTags
	au!
	au FileType * call s:load_dict(&ft)
augroup END


