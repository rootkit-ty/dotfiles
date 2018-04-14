"autocmd Filetype java map <C-o> :JavaImportOrganize<Return>
"autocmd Filetype java map <C-g> :JavaGetSet<Return>
inoremap <Space><Tab> <Esc>/<++><Enter>"_c4l

"autocmd filetype java setl ofu=syntaxcomplete#Complete
autocmd FileType php setl ofu=phpcomplete#CompletePHP
autocmd FileType ruby,eruby setl ofu=rubycomplete#Complete
autocmd FileType html,xhtml setl ofu=htmlcomplete#CompleteTags
autocmd FileType c setl ofu=ccomplete#CompleteCpp
autocmd FileType css setl ofu=csscomplete#CompleteCSS

autocmd FileType markdown inoremap <F5> <esc>:!pandoc<space><c-r>%<space>-o<space><c-r>%.pdf<enter>a
autocmd FileType markdown nnoremap <F5> :!pandoc<space><c-r>%<space>-o<space><c-r>%.pdf<enter>
autocmd Filetype markdown inoremap ;n ---<Enter><Enter>
autocmd Filetype markdown inoremap ;b ****<Space><++><Esc>F*hi
autocmd Filetype markdown inoremap ;s ~~~~<Space><++><Esc>F~hi
autocmd Filetype markdown inoremap ;e **<Space><++><Esc>F*i
autocmd Filetype markdown inoremap ;h ====<Space><++><Esc>F=hi
autocmd Filetype markdown inoremap ;i ![](<++>)<Space><++><Esc>F[a
autocmd Filetype markdown inoremap ;a [](<++>)<Space><++><Esc>F[a
autocmd Filetype markdown inoremap ;1 #<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap ;2 ##<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap ;3 ###<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap ;4 ####<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap ;5 #####<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap ;6 ######<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap ;c <Space><Space><Space><Space><Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap ;l --------<Enter>
autocmd Filetype markdown inoremap ;m <Return><Return><!--more--><Return><Return>
autocmd Filetype markdown inoremap ;k <kbd></kbd><Space><++><Esc>2F>a
autocmd Filetype markdown inoremap ;# {#}<Space><++><Esc>F#a
autocmd Filetype markdown inoremap ;* *<Return><++><Esc>k$a<Space>


"Private functions
autocmd Filetype java inoremap ;frv private<Space>void<Space>(){<Return>}<Return><++><Esc>kO<++><Esc>?void<Return>wi
autocmd Filetype java inoremap ;frb private<Space>bool<Space>(){<Return>}<Return><++><Esc>kO<++><Esc>?bool<Return>wi
autocmd Filetype java inoremap ;fri private<Space>int<Space>(){<Return>}<Return><++><Esc>kO<++><Esc>?int<Return>wi
autocmd Filetype java inoremap ;frf private<Space>float<Space>(){<Return>}<Return><++><Esc>kO<++><Esc>?float<Return>wi
autocmd Filetype java inoremap ;frs private<Space>String<Space>(){<Return>}<Return><++><Esc>kO<++><Esc>?string<Return>wi

"Private static functions
autocmd Filetype java inoremap ;fsrv private<Space>static<Space>void<Space>(){<Return>}<Return><++><Esc>kO<++><Esc>?void<Return>wi
autocmd Filetype java inoremap ;fsrb private<Space>static<Space>bool<Space>(){<Return>}<Return><++><Esc>kO<++><Esc>?bool<Return>wi
autocmd Filetype java inoremap ;fsri private<Space>static<Space>int<Space>(){<Return>}<Return><++><Esc>kO<++><Esc>?int<Return>wi
autocmd Filetype java inoremap ;fsrf private<Space>static<Space>float<Space>(){<Return>}<Return><++><Esc>kO<++><Esc>?float<Return>wi
autocmd Filetype java inoremap ;fsrs private<Space>static<Space>String<Space>(){<Return>}<Return><++><Esc>kO<++><Esc>?String<Return>wi

"Public functions
autocmd Filetype java inoremap ;fuv public<Space>void<Space>(){<Return>}<Return><++><Esc>kO<++><Esc>?void<Return>wi
autocmd Filetype java inoremap ;fub public<Space>bool<Space>(){<Return>}<Return><++><Esc>kO<++><Esc>?bool<Return>wi
autocmd Filetype java inoremap ;fui public<Space>int<Space>(){<Return>}<Return><++><Esc>kO<++><Esc>?int<Return>wi
autocmd Filetype java inoremap ;fuf public<Space>float<Space>(){<Return>}<Return><++><Esc>kO<++><Esc>?float<Return>wi
autocmd Filetype java inoremap ;fus public<Space>String<Space>(){<Return>}<Return><++><Esc>kO<++><Esc>?string<Return>wi

"Public static functions
autocmd Filetype java inoremap ;fsuv public<Space>static<Space>void<Space>(){<Return>}<Return><++><Esc>kO<++><Esc>?void<Return>wi
autocmd Filetype java inoremap ;fsub public<Space>static<Space>bool<Space>(){<Return>}<Return><++><Esc>kO<++><Esc>?bool<Return>wi
autocmd Filetype java inoremap ;fsui public<Space>static<Space>int<Space>(){<Return>}<Return><++><Esc>kO<++><Esc>?int<Return>wi
autocmd Filetype java inoremap ;fsuf public<Space>static<Space>float<Space>(){<Return>}<Return><++><Esc>kO<++><Esc>?float<Return>wi
autocmd Filetype java inoremap ;fsus public<Space>static<Space>String<Space>(){<Return>}<Return><++><Esc>kO<++><Esc>?String<Return>wi


" Private variables
autocmd Filetype java inoremap ;viu private<Space>;<Return><++><Esc>k$f\;i


autocmd Filetype java inoremap ;pk package<Space><Return><++><Esc>k$a
autocmd Filetype java inoremap ;uc public<Space>class<Space>{<Return>}<Esc>O<++><Esc>k$i

autocmd Filetype java inoremap ;ld log.debug("");<Esc>F"i
autocmd Filetype java inoremap ;li log.info("");<Esc>F"i
autocmd Filetype java inoremap ;le log.error("");<Esc>F"i
