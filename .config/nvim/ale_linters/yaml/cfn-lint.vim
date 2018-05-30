""" Author: TODO
function! Handle(buffer, lines) abort
    " Matches patterns line the following:
    " something.yaml:1:1: [warning] missing document start "---" (document-start)
    " something.yml:2:1: [error] syntax error: expected the node content, but found '<stream end>'
    "let l:pattern = '\(ERROR\|WARNING\)\s-\sTemplate\s.*\.yaml\s\(.*\)\sat\sline\s\(\d*\).*column\s\(\d*\)'
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
\   'executable': '/usr/local/bin/cfn-lint',
\   'command': '/usr/local/bin/cfn-lint --template %t --format parseable',
\   'callback': 'Handle',
\})
