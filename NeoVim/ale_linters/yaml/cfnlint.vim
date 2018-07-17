""" Author: Rootkitty <kitty@rootkitty.tech>

let g:ale_yaml_cfnlint_executable =
			\   get(g:, 'ale_yaml_cfnlint_executable', '/usr/local/bin/cfn-lint')

let g:ale_yaml_cfnlint_options =
			\   get(g:, 'ale_yaml_cfnlint_options', '')

function! ale_linters#yaml#cfnlint#GetExecutable(buffer) abort
	return ale#Var(a:buffer, 'yaml_cfnlint_executable')
endfunction

function! ale_linters#yaml#cfnlint#GetCommand(buffer) abort
	return ale_linters#yaml#cfnlint#GetExecutable(a:buffer)
				\   . ' ' . ale#Var(a:buffer, 'yaml_cfnlint_options')
				\   . ' --template %t --format parsable'
endfunction

function! ale_linters#yaml#cfnlint#Handle(buffer, lines) abort
	" Matches patterns line the following:
	let l:pattern = '^.*:\(\d\+\):\(\d\+\): \[\(E\|W\)\(\d\+\)\] \(.\+\)$'
	let l:output = []

	for l:line in a:lines
		echom l:line
	endfor
	for l:match in ale#util#GetMatches(a:lines, l:pattern)
		let l:line = l:match[1] + 0
		let l:col = l:match[2] + 0
		let l:type = l:match[3]
		let l:text = '[' . l:match[3] . l:match[4] . '] ' . l:match[5]

		call add(l:output, {
					\   'lnum': l:line,
					\   'col': l:col,
					\   'text': l:text,
					\   'type': l:type is# 'E' ? 'E' : 'W',
					\})
	endfor

	return l:output
endfunction


call ale#linter#Define('yaml', {
			\   'name': 'cfnlint',
			\   'executable_callback': 'ale_linters#yaml#cfnlint#GetExecutable',
			\   'command_callback': 'ale_linters#yaml#cfnlint#GetCommand',
			\   'callback': 'ale_linters#yaml#cfnlint#Handle',
			\})

" call ale#linter#Define('yaml', {
" \   'name': 'cfnlint',
" \   'executable': '/usr/local/bin/cfn-lint',
" \   'command': '/usr/local/bin/cfn-lint --template %t --format parseable',
" \   'callback': 'ale_linters#yaml#cfnlint#Handle',
" \})
