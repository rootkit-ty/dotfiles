inoremap <Space><Tab> <Esc>/<++><Enter>"_c4l

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
